# SPDX-FileCopyrightText: 2023 The omnibus Authors
# SPDX-FileCopyrightText: 2024 The omnibus Authors
#
# SPDX-License-Identifier: MIT

{ inputs }:
with inputs.dmerge;
{
  data = {
    commit.conventional.scopes = append [
      "nixosModules"
      "nixosProfiles"
      "homeProfiles"
      "homeModules"
      "darwinModules"
      "darwinProfiles"
      ".*."
    ];
  };
}
