# SPDX-FileCopyrightText: 2023 The omnibus Authors
# SPDX-FileCopyrightText: 2024 The omnibus Authors
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
      eachSystem = lib.genAttrs [
        "x86_64-linux"
        "x86_64-darwin"
        "aarch64-linux"
        "aarch64-darwin"
      ];
    in
    {
      examples = eachSystem (
        system:
        omnibus.load {
          src = ./.;
          transformer = [ (_cursor: dir: if dir ? default then dir.default else dir) ];
          inputs = inputs.nixpkgs.lib.recursiveUpdate omnibus.lib.omnibus.loaderInputs {
            inherit system;
            inherit inputs;
            debug = true;
          };
        }
      );
      packages = eachSystem (
        system:
        self.examples.${system}.packages.exports.derivations

          default = inputs.nixpkgs.legacyPackages.${system}.hello;
        }
      );
    }
    // {
      templates = {
        simple = {
          path = ./simple;
          description = "Omnibus & simple case";
          welcomeText = ''
            You have created a simple case template!
          '';
        };
        stdDefault = {
          path = ./stdDefault;
          description = "Omnibus & std & flake-parts";
          welcomeText = ''
            You have created a stdDefault template!
          '';
        };
      };
    };
}
