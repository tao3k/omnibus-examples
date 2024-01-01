# SPDX-FileCopyrightText: 2023 The omnibus Authors
#
# SPDX-License-Identifier: MIT
{
  description = "A very basic flake";

  inputs.omnibus.url = "github:gtrunsec/omnibus";
  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

  outputs =
    { self, omnibus, ... }@inputs:
    let
      inherit (inputs.nixpkgs) lib;
      inherit (omnibus.flake.inputs) std;
      systems = [
        "x86_64-linux"
        "aarch64-linux"
        "aarch64-darwin"
      ];
      omnibusStd =
        (omnibus.pops.std {
          inputs.inputs = {
            inherit std;
          };
        }).exports.default;
    in
    omnibusStd.mkStandardStd {
      cellsFrom = ./cells;
      inherit systems inputs;
    };
}
