# SPDX-FileCopyrightText: 2024 The omnibus Authors
#
# SPDX-License-Identifier: MIT

# [[file:../../docs/org/pops-packages.org::*Example][Example:1]]
{
  omnibus,
  inputs,
  system,
}:
let
  nixpkgs = inputs.nixpkgs.legacyPackages.${system};
in
(omnibus.pops.packages {
  src = ./__fixture;
  inputs = {
    inputs = {
      inherit nixpkgs;
    };
  };
})
# => out.exports { default = {...}, packages = {...}; }
# Example:1 ends here
