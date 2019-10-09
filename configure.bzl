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
"""Rules for configuring the C++ cross-toolchain."""

def _impl(repository_ctx):
    dir_labels = repository_ctx.attr.additional_system_include_directories
    additional_include_dirs = ", ".join([
        '"%s"' % repository_ctx.path(dir_label.relative("BUILD")).dirname
        for dir_label in dir_labels
    ])

    gcc_version = repository_ctx.execute(["/bin/bash", "-c", "gcc -dumpversion | cut -f1 -d."]).stdout
    bcm2708_toolchain_root = repository_ctx.os.environ.get("BCM2708_TOOLCHAIN_ROOT", "/tools/arm-bcm2708")
    repository_ctx.symlink(Label("//:BUILD.tpl"), "BUILD")
    repository_ctx.template(
        "cc_toolchain_config.bzl",
        Label("//:cc_toolchain_config.bzl.tpl"),
        {
            "%{gcc_version}%": gcc_version,
            "%{c_version}%": repository_ctx.attr.c_version,
            "%{cpp_version}%": repository_ctx.attr.cpp_version,
            "%{bcm2708_toolchain_root}%": bcm2708_toolchain_root,
            "%{additional_system_include_directories}%": additional_include_dirs,
        },
    )

cc_crosstool = repository_rule(
    environ = [
        "BCM2708_TOOLCHAIN_ROOT",
    ],
    attrs = {
        # Consult https://gcc.gnu.org/onlinedocs/gcc/C-Dialect-Options.html for
        # valid c_version and cpp_version values (-std option).
        "c_version": attr.string(default = "c99"),
        "cpp_version": attr.string(default = "c++11"),
        "additional_system_include_directories": attr.label_list(allow_files = True),
    },
    implementation = _impl,
    local = True,
)
