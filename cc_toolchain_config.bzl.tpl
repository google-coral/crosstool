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

load(
    "@bazel_tools//tools/cpp:cc_toolchain_config_lib.bzl",
    "action_config",
    "feature",
    "flag_group",
    "flag_set",
    "tool",
    "tool_path",
    "with_feature_set",
)
load("@bazel_tools//tools/build_defs/cc:action_names.bzl", "ACTION_NAMES")

ALL_COMPILE_ACTIONS = [
    ACTION_NAMES.c_compile,
    ACTION_NAMES.cpp_compile,
    ACTION_NAMES.linkstamp_compile,
    ACTION_NAMES.assemble,
    ACTION_NAMES.preprocess_assemble,
    ACTION_NAMES.cpp_header_parsing,
    ACTION_NAMES.cpp_module_compile,
    ACTION_NAMES.cpp_module_codegen,
    ACTION_NAMES.clif_match,
    ACTION_NAMES.lto_backend,
]

ALL_LINK_ACTIONS = [
    ACTION_NAMES.cpp_link_executable,
    ACTION_NAMES.cpp_link_dynamic_library,
    ACTION_NAMES.cpp_link_nodeps_dynamic_library,
]

def make_tool_paths(prefix):
    return [
        tool_path(name = "ar",        path = prefix + "ar"),
        tool_path(name = "as",        path = prefix + "as"),
        tool_path(name = "compat-ld", path = prefix + "ld"),
        tool_path(name = "cpp",       path = prefix + "cpp"),
        tool_path(name = "dwp",       path = prefix + "dwp"),
        tool_path(name = "gcc",       path = prefix + "gcc"),
        tool_path(name = "gcov",      path = prefix + "gcov"),
        tool_path(name = "ld",        path = prefix + "ld"),
        tool_path(name = "nm",        path = prefix + "nm"),
        tool_path(name = "objcopy",   path = prefix + "objcopy"),
        tool_path(name = "objdump",   path = prefix + "objdump"),
        tool_path(name = "strip",     path = prefix + "strip"),
    ]

C_VERSION = "%{c_version}%"
CPP_VERSION = "%{cpp_version}%"

# gcc -dumpversion | cut -f1 -d.
GCC_VERSION = %{gcc_version}%

# gcc -E -xc++ - -v
CXX_BUILTIN_INCLUDE_DIRECTORIES = {
    "k8": [
        "/usr/include/c++/%d" % GCC_VERSION,
        "/usr/include/x86_64-linux-gnu/c++/%d" % GCC_VERSION,
        "/usr/include/c++/%d/backward" % GCC_VERSION,
        "/usr/lib/gcc/x86_64-linux-gnu/%d/include" % GCC_VERSION,
        "/usr/local/include",
        "/usr/lib/gcc/x86_64-linux-gnu/%d/include-fixed" % GCC_VERSION,
        "/usr/include/x86_64-linux-gnu",
        "/usr/include",
    ],
    "armv7a": [
        "/usr/arm-linux-gnueabihf/include/c++/%d" % GCC_VERSION,
        "/usr/arm-linux-gnueabihf/include/c++/%d/arm-linux-gnueabihf" % GCC_VERSION,
        "/usr/arm-linux-gnueabihf/include/c++/%d/backward" % GCC_VERSION,
        "/usr/lib/gcc-cross/arm-linux-gnueabihf/%d/include" % GCC_VERSION,
        "/usr/lib/gcc-cross/arm-linux-gnueabihf/%d/include-fixed" % GCC_VERSION,
        "/usr/arm-linux-gnueabihf/include",
        "/usr/include/arm-linux-gnueabihf",
        "/usr/include"
    ],
    "armv6": [
        "%{bcm2708_toolchain_root}%/arm-linux-gnueabihf/arm-linux-gnueabihf/include/c++/4.9.3",
        "%{bcm2708_toolchain_root}%/arm-linux-gnueabihf/arm-linux-gnueabihf/include/c++/4.9.3/arm-linux-gnueabihf",
        "%{bcm2708_toolchain_root}%/arm-linux-gnueabihf/arm-linux-gnueabihf/include/c++/4.9.3/backward",
        "%{bcm2708_toolchain_root}%/arm-linux-gnueabihf/lib/gcc/arm-linux-gnueabihf/4.9.3/include",
        "%{bcm2708_toolchain_root}%/arm-linux-gnueabihf/lib/gcc/arm-linux-gnueabihf/4.9.3/include-fixed",
        "%{bcm2708_toolchain_root}%/arm-linux-gnueabihf/arm-linux-gnueabihf/include",
        "%{bcm2708_toolchain_root}%/arm-linux-gnueabihf/arm-linux-gnueabihf/sysroot/usr/include",
    ],
    "aarch64": [
        "/usr/aarch64-linux-gnu/include/c++/%d" % GCC_VERSION,
        "/usr/aarch64-linux-gnu/include/c++/%d/aarch64-linux-gnu" % GCC_VERSION,
        "/usr/aarch64-linux-gnu/include/c++/%d/backward" % GCC_VERSION,
        "/usr/lib/gcc-cross/aarch64-linux-gnu/%d/include" % GCC_VERSION,
        "/usr/lib/gcc-cross/aarch64-linux-gnu/%d/include-fixed" % GCC_VERSION,
        "/usr/aarch64-linux-gnu/include",
        "/usr/include/aarch64-linux-gnu",
        "/usr/include",
    ],
    "riscv64": [
        "/usr/riscv64-linux-gnu/include/c++/%d" % GCC_VERSION,
        "/usr/riscv64-linux-gnu/include/c++/%d/riscv64-linux-gnu" % GCC_VERSION,
        "/usr/riscv64-linux-gnu/include/c++/%d/backward" % GCC_VERSION,
        "/usr/lib/gcc-cross/riscv64-linux-gnu/%d/include" % GCC_VERSION,
        "/usr/lib/gcc-cross/riscv64-linux-gnu/%d/include-fixed" % GCC_VERSION,
        "/usr/riscv64-linux-gnu/include",
        "/usr/include/riscv64-linux-gnu",
        "/usr/include",
    ],
    "s390x": [
        "/usr/s390x-linux-gnu/include/c++/%d" % GCC_VERSION,
        "/usr/s390x-linux-gnu/include/c++/%d/s390x-linux-gnu" % GCC_VERSION,
        "/usr/s390x-linux-gnu/include/c++/%d/backward" % GCC_VERSION,
        "/usr/lib/gcc-cross/s390x-linux-gnu/%d/include" % GCC_VERSION,
        "/usr/lib/gcc-cross/s390x-linux-gnu/%d/include-fixed" % GCC_VERSION,
        "/usr/s390x-linux-gnu/include",
        "/usr/include/s390x-linux-gnu",
        "/usr/include",
    ],
    "ppc64el": [
        "/usr/powerpc64le-linux-gnu/include/c++/%d" % GCC_VERSION,
        "/usr/powerpc64le-linux-gnu/include/c++/%d/powerpc64le-linux-gnu" % GCC_VERSION,
        "/usr/powerpc64le-linux-gnu/include/c++/%d/backward" % GCC_VERSION,
        "/usr/lib/gcc-cross/powerpc64le-linux-gnu/%d/include" % GCC_VERSION,
        "/usr/lib/gcc-cross/powerpc64le-linux-gnu/%d/include-fixed" % GCC_VERSION,
        "/usr/powerpc64le-linux-gnu/include",
        "/usr/include/powerpc64le-linux-gnu",
        "/usr/include",
    ]
}

ADDITIONAL_SYSTEM_INCLUDE_DIRECTORIES = [%{additional_system_include_directories}%]

TOOL_PATH_PREFIX = {
    "k8":      "/usr/bin/",
    "armv7a":  "/usr/bin/arm-linux-gnueabihf-",
    "armv6":   "%{bcm2708_toolchain_root}%/arm-linux-gnueabihf/bin/arm-linux-gnueabihf-",
    "aarch64": "/usr/bin/aarch64-linux-gnu-",
    "riscv64": "/usr/bin/riscv64-linux-gnu-",
    "s390x": "/usr/bin/s390x-linux-gnu-",
    "ppc64el": "/usr/bin/powerpc64le-linux-gnu-",
}

HOST_SYSTEM_NAME = "x86_64-linux-gnu"
TARGET_SYSTEM_NAME = {
    "k8":      "x86_64-linux-gnu",
    "armv7a":  "arm-linux-gnueabihf",
    "armv6":   "arm-linux-gnueabihf",
    "aarch64": "aarch64-linux-gnu",
    "riscv64": "riscv64-linux-gnu",
    "s390x":   "s390x-linux-gnu",
    "ppc64el": "powerpc64le-linux-gnu",
}

COMPILE_FLAGS = {
    "k8":      ["-msse4.2"],
    "armv7a":  ["-march=armv7-a", "-mfpu=neon-vfpv4"],
    "armv6":   [],
    "aarch64": ["-march=armv8-a"],
    "riscv64": [],
    "s390x": [],
    "ppc64el": [],
}

COMMON_OPT_COMPILE_FLAGS = [
    "-g0",
    "-O3",
    "-DNDEBUG",
    "-D_FORTIFY_SOURCE=2",
    "-ffunction-sections",
    "-fdata-sections",
]

NON_K8_OPT_COMPILE_FLAGS = [
    "-funsafe-math-optimizations",
    "-ftree-vectorize",
]

OPT_COMPILE_FLAGS = {
    "k8":      COMMON_OPT_COMPILE_FLAGS,
    "armv7a":  COMMON_OPT_COMPILE_FLAGS + NON_K8_OPT_COMPILE_FLAGS,
    "armv6":   COMMON_OPT_COMPILE_FLAGS + NON_K8_OPT_COMPILE_FLAGS,
    "aarch64": COMMON_OPT_COMPILE_FLAGS + NON_K8_OPT_COMPILE_FLAGS,
    "riscv64": COMMON_OPT_COMPILE_FLAGS + NON_K8_OPT_COMPILE_FLAGS,
    "s390x":   COMMON_OPT_COMPILE_FLAGS + NON_K8_OPT_COMPILE_FLAGS,
    "ppc64el": COMMON_OPT_COMPILE_FLAGS + NON_K8_OPT_COMPILE_FLAGS,
}

COMMON_LINKER_FLAGS = [
    "-lstdc++",
    "-lm",
    "-Wl,-no-as-needed",
    "-Wl,-z,relro,-z,now",
    "-Wall",
    "-pass-exit-codes",
]

GOLD_LINKER_FLAG = "-fuse-ld=gold"
LINKER_FLAGS = {
    "k8":      [GOLD_LINKER_FLAG],
    "armv7a":  [GOLD_LINKER_FLAG],
    "armv6":   [GOLD_LINKER_FLAG],
    "aarch64": [GOLD_LINKER_FLAG],
    "riscv64": [],
    "s390x":   [GOLD_LINKER_FLAG],
    "ppc64el": [GOLD_LINKER_FLAG],
}

def _impl(ctx):
    unfiltered_compile_flags_feature = feature(
        name = "unfiltered_compile_flags",
        enabled = True,
        flag_sets = [
            flag_set(
                actions = ALL_COMPILE_ACTIONS,
                flag_groups = [
                    flag_group(
                        flags = [
                            "-no-canonical-prefixes",
                            "-fno-canonical-system-headers",
                            "-Wno-builtin-macro-redefined",
                            "-D__DATE__=\"redacted\"",
                            "-D__TIMESTAMP__=\"redacted\"",
                            "-D__TIME__=\"redacted\"",
                        ],
                    ),
                ],
            ),
        ],
    )

    default_compile_flags_feature = feature(
        name = "default_compile_flags",
        enabled = True,
        flag_sets = [
            flag_set(
                actions = ALL_COMPILE_ACTIONS,
                flag_groups = [
                    flag_group(
                        flags = [
                            "-fPIC",
                            "-U_FORTIFY_SOURCE",
                            "-fstack-protector",
                            "-Wall",
                            "-Wunused-but-set-parameter",
                            "-Wno-free-nonheap-object",
                            "-fno-omit-frame-pointer",
                            # "-fmessage-length=0",
                            # "-fno-omit-frame-pointer",
                            # "-fno-strict-aliasing",
                            # "-fdebug-types-section",
                        ],
                    ),
                ],
            ),
            flag_set(
                actions = ALL_COMPILE_ACTIONS,
                flag_groups = [
                    flag_group(flags = COMPILE_FLAGS[ctx.attr.cpu] + ["-g"])
                ],
                with_features = [with_feature_set(features = ["dbg"])],
            ),
            flag_set(
                actions = ALL_COMPILE_ACTIONS,
                flag_groups = [
                    flag_group(
                        flags = COMPILE_FLAGS[ctx.attr.cpu] + OPT_COMPILE_FLAGS[ctx.attr.cpu],
                    ),
                ],
                with_features = [with_feature_set(features = ["opt"])],
            ),
            flag_set(
                actions = [
                    ACTION_NAMES.linkstamp_compile,
                    ACTION_NAMES.cpp_compile,
                    ACTION_NAMES.cpp_header_parsing,
                    ACTION_NAMES.cpp_module_compile,
                    ACTION_NAMES.cpp_module_codegen,
                    ACTION_NAMES.lto_backend,
                    ACTION_NAMES.clif_match,
                ],
                flag_groups = [
                    flag_group(
                        flags = [
                            "-std=" + CPP_VERSION,
                        ] + [f for d in ADDITIONAL_SYSTEM_INCLUDE_DIRECTORIES for f in  ('-isystem', d)],
                    ),
                ],
            ),
            flag_set(
                actions = [
                    ACTION_NAMES.c_compile,
                ],
                flag_groups = [
                    flag_group(
                        flags = [
                            "-std=" + C_VERSION,
                        ] + [f for d in ADDITIONAL_SYSTEM_INCLUDE_DIRECTORIES for f in  ('-isystem', d)],
                    ),
                ],
            ),
        ],
    )

    supports_dynamic_linker_feature = feature(
        name = "supports_dynamic_linker",
        enabled = True,
    )

    user_compile_flags_feature = feature(
        name = "user_compile_flags",
        enabled = True,
        flag_sets = [
            flag_set(
                actions = ALL_COMPILE_ACTIONS,
                flag_groups = [
                    flag_group(
                        flags = ["%{user_compile_flags}"],
                        iterate_over = "user_compile_flags",
                        expand_if_available = "user_compile_flags",
                    ),
                ],
            ),
        ],
    )

    default_link_flags_feature = feature(
        name = "default_link_flags",
        enabled = True,
        flag_sets = [
            flag_set(
                actions = ALL_LINK_ACTIONS,
                flag_groups = [
                    flag_group(
                        flags = COMMON_LINKER_FLAGS + LINKER_FLAGS[ctx.attr.cpu]
                    ),
                ],
            ),
            flag_set(
                actions = ALL_LINK_ACTIONS,
                flag_groups = [
                    flag_group(flags = ["-Wl,--gc-sections"])
                ],
                with_features = [with_feature_set(features = ["opt"])],
            ),
            flag_set(
                actions = ALL_LINK_ACTIONS,
                flag_groups = [
                    flag_group(
                        flags = [
                            "-Wl,--whole-archive",
                            "-Wl,-lpthread",
                            "-Wl,--no-whole-archive",
                        ],
                    ),
                ],
                with_features = [
                    with_feature_set(features = [
                        "fully_static_link",
                        "static_linking_mode",
                    ]),
                ],
            ),
        ],
    )

    return cc_common.create_cc_toolchain_config_info(
            ctx = ctx,
            features = [
                feature(name = "static_linking_mode"),
                feature(name = "fully_static_link"),
                feature(name = "dynamic_linking_mode"),
                feature(name = "dbg"),
                feature(name = "opt"),

                default_compile_flags_feature,
                default_link_flags_feature,
                supports_dynamic_linker_feature,
                user_compile_flags_feature,
                unfiltered_compile_flags_feature,
            ],
            action_configs = [],
            artifact_name_patterns = [],
            cxx_builtin_include_directories = (
                ADDITIONAL_SYSTEM_INCLUDE_DIRECTORIES +
                CXX_BUILTIN_INCLUDE_DIRECTORIES[ctx.attr.cpu]
            ),
            toolchain_identifier = ctx.attr.cpu + '-toolchain',
            host_system_name = HOST_SYSTEM_NAME,
            target_system_name = TARGET_SYSTEM_NAME[ctx.attr.cpu],
            target_cpu = ctx.attr.cpu,
            target_libc = "local",
            compiler = "gcc",
            abi_version = "local",
            abi_libc_version = "local",
            tool_paths = make_tool_paths(TOOL_PATH_PREFIX[ctx.attr.cpu]),
            make_variables = [],
        )

cc_toolchain_config = rule(
    implementation = _impl,
    attrs = {
        "cpu": attr.string(mandatory = True, values = ["armv7a", "armv6", "aarch64", "k8", "riscv64", "s390x", "ppc64el"]),
    },
    provides = [CcToolchainConfigInfo],
)
