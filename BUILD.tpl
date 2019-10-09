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

filegroup(name = "empty")

cc_toolchain_suite(
    name = "toolchains",
    toolchains = {
      "aarch64"    : ":cc-compiler-aarch64",
      "aarch64|gcc": ":cc-compiler-aarch64",
      "armv7a"     : ":cc-compiler-armv7a",
      "armv7a|gcc" : ":cc-compiler-armv7a",
      "armv6"      : ":cc-compiler-armv6",
      "armv6|gcc"  : ":cc-compiler-armv6",
      "k8"         : ":cc-compiler-k8",
      "k8|gcc"     : ":cc-compiler-k8",
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
