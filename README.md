# Bazel cross-compilation toolchains

[Bazel](https://bazel.build) build system supports integration with custom C/C++
toolchains. This project defines toolchains for x86_64 (64 bit), ARMv7-A (32 bit),
and ARMv8-A (64 bit) processors based on the standard Linux crosstool packages.

The steps below describe how to setup cross-compilation for projects at
github.com/google-coral/.


### Step 1: Install required crosstool packages

```
dpkg --add-architecture armhf
dpkg --add-architecture arm64

apt-get update && apt-get install -y build-essential crossbuild-essential-armhf crossbuild-essential-arm64
```

### Step 2: Update `WORKSPACE` file

You need to know the exact git commit of this repo to use:

```
COMMIT=$(git ls-remote https://github.com/google-coral/crosstool master | awk '{print $1}')
```

and corresponding SHA-256 hash:

```
SHA256=$(curl -L "https://github.com/google-coral/crosstool/archive/${COMMIT}.tar.gz" | sha256sum | awk '{print $1}')
```

Add the following piece of code to your `WORKSPACE` file while replacing
`${COMMIT}` and `${SHA256}` values:

```
http_archive(
    name = "coral_crosstool",
    sha256 = "${SHA256}",
    strip_prefix = "crosstool-${COMMIT}",
    urls = [
        "https://github.com/google-coral/crosstool/archive/${COMMIT}.tar.gz",
    ],
)

load("@coral_crosstool//:configure.bzl", "cc_crosstool")
cc_crosstool(name = "crosstool")
```

### Step 3: Add additional command line arguments to bazel build command

To compile for regular x86_64:

```
bazel build --crosstool_top=@crosstool//:toolchains --compiler=gcc --cpu=k8 <OPTIONS>
```

To compile for ARMv7-A (e.g. Raspberry Pi 3 or 4):

```
bazel build --crosstool_top=@crosstool//:toolchains --compiler=gcc --cpu=armv7a <OPTIONS>
```

To compile for ARMv8-A (e.g. Coral Dev Board):

```
bazel build --crosstool_top=@crosstool//:toolchains --compiler=gcc --cpu=aarch64 <OPTIONS>
```
