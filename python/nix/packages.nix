# SPDX-FileCopyrightText: 2024 The omnibus Authors
#
# SPDX-License-Identifier: MIT

# [[file:../../docs/org/pops-packages.org::*Example][Example:1]]
{
  omnibus,
  inputs,
  system,
  projectRoot,
}:
let
  nixpkgs = inputs.nixpkgs.legacyPackages.${system}.appendOverlays [
    inputs.poetry2nix.overlays.default
  ];
in
(omnibus.pops.packages {
  src = projectRoot + /nix/packages;
  inputs = {
    inputs = {
      inherit nixpkgs;
    };
  };
})
# => out.exports { default = {...}, packages = {...}; }
# Example:1 ends here
