{
  myvars,
  lib,
}: let
  username = myvars.username;
  hosts = [
    "madhu"
  ];
in
  lib.genAttrs hosts (_: "/Users/${username}")
