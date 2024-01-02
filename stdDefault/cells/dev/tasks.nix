{
  hello = inputs.nixpkgs.writeShellApplication {
    name = "writeShellApplication";
    text = ''
      echo tasks.hello
    '';
  };
}
