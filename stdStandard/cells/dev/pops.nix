# SPDX-FileCopyrightText: 2024 The omnibus Authors
#
# SPDX-License-Identifier: MIT

{ inputs, cell }@commonArgs:
let
  inherit (inputs) omnibusStd;
in
omnibusStd.mkBlocks.pops commonArgs {
  scripts = {
    src = ./scripts;
  };
  configs = {
    src = ./configs;
  };
  devshellProfiles = {
    src = ./devshellProfiles;
    inputs = {
      inputs = {
        inherit (inputs.omnibus.flake.inputs) devshell;
      };
    };
  };
}
