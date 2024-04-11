{ inputs, cell }:
let
  inherit (inputs.std) lib;
  inherit (inputs) std;
in
{
  # Tool Homepage: https://numtide.github.io/devshell/
  default = lib.dev.mkShell {
    name = "Std devshell";

    imports = [
      cell.devshellProfiles.test-b
      cell.devshellProfiles.test
    ];

    commands = [ ];
  };
}
