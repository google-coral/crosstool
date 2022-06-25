# Copyright 2019 Google LLC
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     https://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

package(default_visibility = ["//visibility:public"])

licenses(["notice"])

load(":cc_toolchain_config.bzl", "cc_toolchain_config")
load(":windows_cc_toolchain_config.bzl", "windows_cc_toolchain_config")

filegroup(name = "empty")

cc_toolchain_suite(
    name = "toolchains",
    toolchains = {
      "aarch64"         : ":cc-compiler-aarch64",
      "aarch64-musl"    : ":cc-compiler-aarch64-musl",
      "aarch64|gcc"     : ":cc-compiler-aarch64",
      "armv7a"          : ":cc-compiler-armv7a",
      "armv7a|gcc"      : ":cc-compiler-armv7a",
      "armv6"           : ":cc-compiler-armv6",
      "armv6|gcc"       : ":cc-compiler-armv6",
      "k8"              : ":cc-compiler-k8",
      "k8|gcc"          : ":cc-compiler-k8",
      "riscv64"         : ":cc-compiler-riscv64",
      "riscv64-musl"    : ":cc-compiler-riscv64-musl",
      "riscv64|gcc"     : ":cc-compiler-riscv64",
      "s390x"           : ":cc-compiler-s390x",
      "s390x|gcc"       : ":cc-compiler-s390x",
      "ppc64el"         : ":cc-compiler-ppc64el",
      "ppc64el|gcc"     : ":cc-compiler-ppc64el",
      "x64_windows|msvc-cl": ":cc-compiler-x64_windows",
      "x64_windows|msvc-cl-x64": ":cc-compiler-x64_windows",
      "x64_windows|msvc-cl-arm64": "cc-compiler-arm64_windows",
      "x64_windows": ":cc-compiler-x64_windows",
    }
)

cc_toolchain(
    name = "cc-compiler-aarch64",
    toolchain_config = ":aarch64-config",

    all_files = ":empty",
    compiler_files = ":empty",
    dwp_files = ":empty",
    linker_files = ":empty",
    objcopy_files = ":empty",
    strip_files = ":empty",
)

cc_toolchain_config(name = "aarch64-config", cpu = "aarch64")

cc_toolchain(
    name = "cc-compiler-aarch64-musl",
    toolchain_config = ":aarch64-config-musl",

    all_files = ":empty",
    compiler_files = ":empty",
    dwp_files = ":empty",
    linker_files = ":empty",
    objcopy_files = ":empty",
    strip_files = ":empty",
)

cc_toolchain_config(name = "aarch64-config-musl", cpu = "aarch64-musl")

cc_toolchain(
    name = "cc-compiler-armv7a",
    toolchain_config = ":armv7a-config",

    all_files = ":empty",
    compiler_files = ":empty",
    dwp_files = ":empty",
    linker_files = ":empty",
    objcopy_files = ":empty",
    strip_files = ":empty",
)

cc_toolchain_config(name = "armv7a-config", cpu = "armv7a")

cc_toolchain(
    name = "cc-compiler-armv6",
    toolchain_config = ":armv6-config",

    all_files = ":empty",
    compiler_files = ":empty",
    dwp_files = ":empty",
    linker_files = ":empty",
    objcopy_files = ":empty",
    strip_files = ":empty",
)

cc_toolchain_config(name = "armv6-config", cpu = "armv6")

cc_toolchain(
    name = "cc-compiler-k8",
    toolchain_config = ":k8-config",

    all_files = ":empty",
    compiler_files = ":empty",
    dwp_files = ":empty",
    linker_files = ":empty",
    objcopy_files = ":empty",
    strip_files = ":empty",
)

cc_toolchain_config(name = "k8-config", cpu = "k8")

cc_toolchain(
    name = "cc-compiler-x64_windows",
    toolchain_identifier = "msvc_x64",
    toolchain_config = ":msvc_x64",
    all_files = ":empty",
    ar_files = ":empty",
    as_files = ":empty",
    compiler_files = ":empty",
    dwp_files = ":empty",
    linker_files = ":empty",
    objcopy_files = ":empty",
    strip_files = ":empty",
    supports_param_files = 1,
)

cc_toolchain(
    name = "cc-compiler-riscv64",
    toolchain_config = ":riscv64-config",

    all_files = ":empty",
    compiler_files = ":empty",
    dwp_files = ":empty",
    linker_files = ":empty",
    objcopy_files = ":empty",
    strip_files = ":empty",
)

cc_toolchain_config(name = "riscv64-config", cpu = "riscv64")

cc_toolchain(
    name = "cc-compiler-riscv64-musl",
    toolchain_config = ":riscv64-config-musl",

    all_files = ":empty",
    compiler_files = ":empty",
    dwp_files = ":empty",
    linker_files = ":empty",
    objcopy_files = ":empty",
    strip_files = ":empty",
)

cc_toolchain_config(name = "riscv64-config-musl", cpu = "riscv64-musl")

toolchain(
    name = "cc-toolchain-riscv64",
    exec_compatible_with = [
        "@platforms//cpu:riscv64",
        "@platforms//os:linux",
    ],
    target_compatible_with = [
        "@platforms//cpu:riscv64",
        "@platforms//os:linux",
    ],
    toolchain = ":cc-compiler-riscv64",
    toolchain_type = "@bazel_tools//tools/cpp:toolchain_type",
)

toolchain(
    name = "cc-toolchain-riscv64-musl",
    exec_compatible_with = [
        "@platforms//cpu:riscv64",
        "@platforms//os:linux",
    ],
    target_compatible_with = [
        "@platforms//cpu:riscv64",
        "@platforms//os:linux",
    ],
    toolchain = ":cc-compiler-riscv64-musl",
    toolchain_type = "@bazel_tools//tools/cpp:toolchain_type",
)

cc_toolchain(
    name = "cc-compiler-s390x",
    toolchain_config = ":s390x-config",

    all_files = ":empty",
    compiler_files = ":empty",
    dwp_files = ":empty",
    linker_files = ":empty",
    objcopy_files = ":empty",
    strip_files = ":empty",
)

cc_toolchain_config(name = "s390x-config", cpu = "s390x")

toolchain(
    name = "cc-toolchain-s390x",
    exec_compatible_with = [
        "@platforms//cpu:s390x",
        "@platforms//os:linux",
    ],
    target_compatible_with = [
        "@platforms//cpu:s390x",
        "@platforms//os:linux",
    ],
    toolchain = ":cc-compiler-s390x",
    toolchain_type = "@bazel_tools//tools/cpp:toolchain_type",
)

cc_toolchain(
    name = "cc-compiler-ppc64el",
    toolchain_config = ":ppc64el-config",

    all_files = ":empty",
    compiler_files = ":empty",
    dwp_files = ":empty",
    linker_files = ":empty",
    objcopy_files = ":empty",
    strip_files = ":empty",
)

cc_toolchain_config(name = "ppc64el-config", cpu = "ppc64el")

toolchain(
    name = "cc-toolchain-ppc64el",
    exec_compatible_with = [
        "@platforms//cpu:ppc64el",
        "@platforms//os:linux",
    ],
    target_compatible_with = [
        "@platforms//cpu:ppc64el",
        "@platforms//os:linux",
    ],
    toolchain = ":cc-compiler-ppc64el",
    toolchain_type = "@bazel_tools//tools/cpp:toolchain_type",
)


windows_cc_toolchain_config(
    name = "msvc_x64",
    cpu = "x64_windows",
    compiler = "msvc-cl",
    host_system_name = "local",
    target_system_name = "local",
    target_libc = "msvcrt",
    abi_version = "local",
    abi_libc_version = "local",
    toolchain_identifier = "msvc_x64",
    msvc_env_tmp = "%{msvc_env_tmp}",
    msvc_env_path = "%{msvc_x64_env_path}",
    msvc_env_include = "%{msvc_x64_env_include}",
    msvc_env_lib = "%{msvc_x64_env_lib}",
    msvc_cl_path = "%{msvc_x64_cl_path}",
    msvc_ml_path = "%{msvc_x64_ml_path}",
    msvc_link_path = "%{msvc_x64_link_path}",
    msvc_lib_path = "%{msvc_x64_lib_path}",
    cxx_builtin_include_directories = [%{msvc_cxx_builtin_include_directories}],
    tool_paths = {
        "ar": "%{msvc_x64_lib_path}",
        "ml": "%{msvc_x64_ml_path}",
        "cpp": "%{msvc_x64_cl_path}",
        "gcc": "%{msvc_x64_cl_path}",
        "gcov": "wrapper/bin/msvc_nop.bat",
        "ld": "%{msvc_x64_link_path}",
        "nm": "wrapper/bin/msvc_nop.bat",
        "objcopy": "wrapper/bin/msvc_nop.bat",
        "objdump": "wrapper/bin/msvc_nop.bat",
        "strip": "wrapper/bin/msvc_nop.bat",
    },
    default_link_flags = ["/MACHINE:X64"],
    dbg_mode_debug_flag = "%{dbg_mode_debug_flag}",
    fastbuild_mode_debug_flag = "%{fastbuild_mode_debug_flag}",
)

toolchain(
    name = "cc-toolchain-x64_windows",
    exec_compatible_with = [
        "@platforms//cpu:x86_64",
        "@platforms//os:windows",
    ],
    target_compatible_with = [
        "@platforms//cpu:x86_64",
        "@platforms//os:windows",
    ],
    toolchain = ":cc-compiler-x64_windows",
    toolchain_type = "@bazel_tools//tools/cpp:toolchain_type",
)

cc_toolchain(
    name = "cc-compiler-arm64_windows",
    toolchain_identifier = "msvc_arm64",
    toolchain_config = ":msvc_arm64",
    all_files = ":empty",
    ar_files = ":empty",
    as_files = ":empty",
    compiler_files = ":empty",
    dwp_files = ":empty",
    linker_files = ":empty",
    objcopy_files = ":empty",
    strip_files = ":empty",
    supports_param_files = 1,
)

windows_cc_toolchain_config(
    name = "msvc_arm64",
    cpu = "x64_windows",
    compiler = "msvc-cl",
    host_system_name = "local",
    target_system_name = "arm64_windows",
    target_libc = "msvcrt",
    abi_version = "local",
    abi_libc_version = "local",
    toolchain_identifier = "msvc_arm64",
    msvc_env_tmp = "%{msvc_env_tmp}",
    msvc_env_path = "%{msvc_arm64_env_path}",
    msvc_env_include = "%{msvc_arm64_env_include}",
    msvc_env_lib = "%{msvc_arm64_env_lib}",
    msvc_cl_path = "%{msvc_arm64_cl_path}",
    msvc_ml_path = "%{msvc_arm64_ml_path}",
    msvc_link_path = "%{msvc_arm64_link_path}",
    msvc_lib_path = "%{msvc_arm64_lib_path}",
    cxx_builtin_include_directories = [%{msvc_cxx_builtin_include_directories}],
    tool_paths = {
        "ar": "%{msvc_arm64_lib_path}",
        "ml": "%{msvc_arm64_ml_path}",
        "cpp": "%{msvc_arm64_cl_path}",
        "gcc": "%{msvc_arm64_cl_path}",
        "gcov": "wrapper/bin/msvc_nop.bat",
        "ld": "%{msvc_arm64_link_path}",
        "nm": "wrapper/bin/msvc_nop.bat",
        "objcopy": "wrapper/bin/msvc_nop.bat",
        "objdump": "wrapper/bin/msvc_nop.bat",
        "strip": "wrapper/bin/msvc_nop.bat",
    },
    default_link_flags = ["/MACHINE:ARM64"],
    dbg_mode_debug_flag = "%{dbg_mode_debug_flag}",
    fastbuild_mode_debug_flag = "%{fastbuild_mode_debug_flag}",
)

toolchain(
    name = "cc-toolchain-arm64_windows",
    exec_compatible_with = [
        "@platforms//cpu:aarch64",
        "@platforms//os:windows",
    ],
    target_compatible_with = [
        "@platforms//cpu:aarch64",
        "@platforms//os:windows",
    ],
    toolchain = ":cc-compiler-arm64_windows",
    toolchain_type = "@bazel_tools//tools/cpp:toolchain_type",
)
