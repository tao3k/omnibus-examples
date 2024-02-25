# SPDX-FileCopyrightText: 2024 The omnibus Authors
#
# SPDX-License-Identifier: MIT

{ inputs, cell }:
let
  inherit (inputs.std) lib;
  inherit (inputs) std;
in
{
  # Tool Homepage: https://numtide.github.io/devshell/
  default = lib.dev.mkShell {
    name = "Std devshell";

    imports = [
      std.std.devshellProfiles.default
      cell.devshellProfiles.commands
    ];

    commands = [ ];
  };
}
