# SPDX-FileCopyrightText: 2024 The omnibus Authors
#
# SPDX-License-Identifier: MIT

{
  config = {
    nixpkgs.hostPlatform = "x86_64-linux";

    services.nginx.enable = true;
  };
}
