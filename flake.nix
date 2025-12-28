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
      supportedSystems = lib.genAttrs [
        "x86_64-linux"
        "aarch64-linux"
        "aarch64-darwin"
      ];
    in
    {
      examples = supportedSystems (
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
      packages = supportedSystems (
        system: self.examples.${system}.packages.exports.derivations
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
