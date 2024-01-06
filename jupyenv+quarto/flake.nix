# SPDX-FileCopyrightText: 2023 The omnibus Authors
#
# SPDX-License-Identifier: MIT

{
  inputs = {
    omnibus.url = "github:gtrunsec/omnibus";
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    jupyenv.url = "github:tweag/jupyenv/?ref=refs/pull/524/head";
    jupyenv.inputs.poetry2nix.follows = "poetry2nix";
    poetry2nix.url = "github:nix-community/poetry2nix";
    poetry2nix.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs =
    { self, ... }@inputs:
    let
      inherit (inputs.nixpkgs) lib;
      eachSystem = lib.genAttrs [
        "x86_64-linux"
        "x86_64-darwin"
        "aarch64-linux"
        "aarch64-darwin"
      ];
      nix-filter = (inputs.omnibus.pops.packages { }).load.inputs.nix-filter;
      pops = {
        src = eachSystem (
          system:
          inputs.omnibus.pops.load {
            src = nix-filter.filter {
              root = ./nix;
              exclude = [
                "packages"
                "jupyenv"
              ];
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
      packages = eachSystem (
        system:
        self.src.${system}.packages.exports.derivations
        // self.src.${system}.jupyenv.exports.jupyenvEnv
      );
      apps = eachSystem (
        system: {
          quartoSimple = {
            type = "app";
            program =
              self.src.${system}.jupyenv.exports.jupyenvEvalModules.simple.config.quartoEnv
              + "/bin/quarto";
          };
        }
      );
      overlays = {
        inherit (self.src.x86_64-linux.packages.exports.overlays)
          default
          composedPackages
          ;
      };
      inherit pops;
    };
}
