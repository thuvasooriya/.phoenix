{myvars, ...}: {
  users.users."${myvars.username}" = {
    home = "/Users/${myvars.username}";
    # do not change the system's default shell, keep it as zsh
  };
}
