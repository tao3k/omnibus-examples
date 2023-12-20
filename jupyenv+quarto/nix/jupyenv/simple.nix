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
}
