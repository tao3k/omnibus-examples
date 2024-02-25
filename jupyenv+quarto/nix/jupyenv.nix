# SPDX-FileCopyrightText: 2024 The omnibus Authors
#
# SPDX-License-Identifier: MIT

{
  omnibus,
  inputs,
  system,
  projectRoot,
}:
let
  nixpkgs = inputs.nixpkgs.legacyPackages.${system};
in
omnibus.pops.jupyenv.addLoadExtender {
  load = {
    src = projectRoot + /nix/jupyenv;
    inputs = {
      inputs = {
        inherit (inputs) jupyenv self;
        inherit nixpkgs;
      };
    };
  };
}
