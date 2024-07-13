{lib, ...}:
# ===================================================================
# remove packages that are not well supported for the darwin platform
# ===================================================================
let
  brokenPackages = [
    "terraform"
    "terraformer"
    "packer"
    "git-trim"
    "conda"
    "mitmproxy"
    "insomnia"
    "wireshark"
    "jsonnet"
    "zls"
    "verible"
    "gdb"
    "ncdu"
    # "curl"
  ];
in {
  nixpkgs.overlays = [
    (_: super: let
      removeUnwantedPackages = pname:
        lib.warn "`${pname}` pkg has been removed since it's broken on darwin"
        super.emptyDirectory;
    in
      lib.genAttrs
      brokenPackages
      removeUnwantedPackages)
  ];
}
