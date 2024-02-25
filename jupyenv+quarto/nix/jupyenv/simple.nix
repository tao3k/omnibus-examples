# SPDX-FileCopyrightText: 2024 The omnibus Authors
#
# SPDX-License-Identifier: MIT

{
  pkgs,
  inputs,
  omnibus,
}:
{
  imports = [ omnibus.jupyenv.quarto ];
  publishers.quarto.enable = true;

  kernel.python.data-science = {
    enable = true;
    env = inputs.self.packages.${pkgs.system}.poetry2nix-custom;
    # extraPackages = ps: [ps.scipy];
  };
  kernel.julia.data-science = {
    enable = true;
    override = {
      augmentedRegistry = pkgs.fetchFromGitHub {
        owner = "CodeDownIO";
        repo = "General";
        rev = "840f93574326361e2614fc5a4c2413f07840215a";
        sha256 = "sha256-UedaTpQwkuSZ/o4kLX/Jg8eDnL5IFI4XfYsJMRwBAKE=";
      };
      # Precompile = true;
    };
    extraJuliaPackages = [ "Plots" ];
  };
}
