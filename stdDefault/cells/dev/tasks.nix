{inputs,cell}:{
  hello = inputs.nixpkgs.writeShellApplication {
    name = "writeShellApplication";
    text = ''
      echo hello
    '';
  };
}
