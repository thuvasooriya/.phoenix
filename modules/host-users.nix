{
  username,
  hostname,
  ...
} @ args: {
  networking.hostName = hostname;
  networking.computerName = hostname;
  system.defaults.smb.NetBIOSName = hostname;

  users.users."${username}" = {
    name = "${user}";
    home = "/Users/${username}";
    description = username;
  };

  nix.settings.trusted-users = [username];
}
