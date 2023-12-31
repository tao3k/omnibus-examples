{ inputs, cell }@commonArgs:
let
  inherit (inputs) omnibusStd;
in
omnibusStd.mkCells.pops commonArgs {
  scripts = {
    src = ./scripts;
  };
  configs = {
    src = ./configs;
  };
  devshellProfiles = {
    src = ./devshellProfiles;
  };
}
