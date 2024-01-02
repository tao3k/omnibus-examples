makeScript {
  name = "runScriptWithEnv";
  searchPaths.bin = [ nixpkgs.hello ];
  searchPaths.source = [ ];
  entrypoint = ''
    hello --help
  '';
}
