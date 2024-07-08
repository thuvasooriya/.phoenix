{
  myvars,
  lib,
  outputs,
}: let
  username = myvars.username;
  hosts = [
    "madhu"
  ];
in
  lib.genAttrs
  hosts
  (
    name: outputs.darwinConfigurations.${name}.config.home-manager.users.${username}.home.homeDirectory
  )
