# SPDX-FileCopyrightText: 2024 The omnibus Authors
#
# SPDX-License-Identifier: MIT

{
  hello = inputs.nixpkgs.writeShellApplication {
    name = "writeShellApplication";
    text = ''
      echo tasks.hello
    '';
  };
}
