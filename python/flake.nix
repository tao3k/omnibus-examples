# SPDX-FileCopyrightText: 2023 The omnibus Authors
# SPDX-FileCopyrightText: 2024 The omnibus Authors
#
# SPDX-License-Identifier: MIT

{
  inputs = {
    omnibus.url = "github:gtrunsec/omnibus";
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs =
    { self, ... }@inputs:
    let
      inherit (inputs.nixpkgs) lib;
      supportedSystems = lib.genAttrs [
        "x86_64-linux"
        "x86_64-darwin"
        "aarch64-linux"
        "aarch64-darwin"
      ];
      nix-filter = (inputs.omnibus.pops.packages { }).load.inputs.nix-filter;
      pops = {
        src = supportedSystems (
          system:
          inputs.omnibus.pops.load {
            src = nix-filter.filter {
              root = ./nix;
              exclude = [ "packages" ];
            };
            inputs = {
              projectRoot = ./.;
              inherit system;
              inherit inputs;
            };
          }
        );
      };
      inherit (inputs.omnibus.lib.omnibus) mapPopsExports;
    in
    mapPopsExports pops
    // {
      packages = supportedSystems (system: self.src.${system}.packages.exports.derivations);
      overlays = {
        inherit (self.src.x86_64-linux.packages.exports.overlays)
          default
          composedPackages
          ;
      };
      inherit pops;
    };
}
