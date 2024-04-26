# SPDX-FileCopyrightText: 2023 The omnibus Authors
# SPDX-FileCopyrightText: 2024 The omnibus Authors
#
# SPDX-License-Identifier: MIT

{
  inputs = {
    omnibus.url = "github:gtrunsec/omnibus";
    nixos-unstable.url = "github:nixos/nixpkgs/nixos-unstable-small";
    home-manager.url = "github:nix-community/home-manager";
  };

  outputs =
    { self, ... }@inputs:
    let
      inherit (inputs.omnibus.inputs.flops.inputs.nixlib) lib;
      eachSystem = lib.genAttrs [
        "x86_64-linux"
        "x86_64-darwin"
        "aarch64-linux"
        "aarch64-darwin"
      ];
      pops = rec {
        hosts = inputs.omnibus.pops.load {
          src = ./hosts;
          inputs = {
            inherit (inputs) nixos-unstable;
            inputs = inputs // { };
          };
        };
        hive = inputs.omnibus.pops.hive.setHosts pops.hosts.exports.default;
      };
    in
    {
      inherit pops;
      inherit (pops.hive.exports) nixosConfigurations darwinConfigurations colmenaHive;
    };
}
