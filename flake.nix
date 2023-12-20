# SPDX-FileCopyrightText: 2023 The omnibus Authors
#
# SPDX-License-Identifier: MIT

{
  description = "A very basic flake";

  inputs.omnibus.url = "github:gtrunsec/omnibus";
  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

  outputs =
    { self, omnibus, ... }@inputs:
    {
      examples = omnibus.load {
        src = ./.;
        transformer = [ (_cursor: dir: if dir ? default then dir.default else dir) ];
        inputs = inputs.nixpkgs.lib.recursiveUpdate omnibus.lib.omnibus.loaderInputs {
          inherit inputs;
          trace = true;
        };
      };
      packages.x86_64-linux = self.examples.packages.exports.derivations;
    };
}
