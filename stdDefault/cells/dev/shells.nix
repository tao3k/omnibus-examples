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
      std.std.devshellProfiles.default
      cell.devshellProfiles.commands
    ];

    commands = [ ];
  };
}
