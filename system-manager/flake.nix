# SPDX-FileCopyrightText: 2023 The omnibus Authors
# SPDX-FileCopyrightText: 2024 The omnibus Authors
#
# SPDX-License-Identifier: MIT

{
  inputs = {
    omnibus.url = "github:gtrunsec/omnibus";
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    system-manager = {
      url = "github:numtide/system-manager";
    };
  };

  outputs =
    { self, system-manager, ... }@inputs:
    let
      inherit (inputs.nixpkgs) lib;
      supportedSystems = lib.genAttrs [
        "x86_64-linux"
        "x86_64-darwin"
        "aarch64-linux"
        "aarch64-darwin"
      ];
      pops = {
        systemManagerProfiles =
          inputs.omnibus.pops.systemManagerProfiles.addLoadExtender
            {
              load = {
                src = ./systemManagerProfiles;
                type = "nixosProfiles";
                inputs = { };
              };
            };
        omnibus = supportedSystems (
          system:
          inputs.omnibus.pops.self.addLoadExtender {
            load.inputs = {
              inputs = {
                nixpkgs = inputs.nixos-unstable.legacyPackages.${system};
              };
            };
          }
        );
      };
      inherit (inputs.omnibus.lib.omnibus) mapPopsExports;
    in
    mapPopsExports pops
    // {
      inherit pops;
      systemConfigs.example = system-manager.lib.makeSystemConfig {
        modules = [
          inputs.omnibus.systemManagerProfiles.presets.init
          self.systemManagerProfiles.example
        ];
      };
    };
}
