{pkgs, ...}: {
  programs = {
    bun = {
      enable = true;
      enableGitIntegration = true;
      package = pkgs.bun.overrideAttrs (oldAttrs: {
        version = "1.1.19"; # replace with the version you want
        # pname = "bun";
        # src = passthru.sources.${stdenvNoCC.hostPlatform.system} or (throw "Unsupported system: ${stdenvNoCC.hostPlatform.system}");
        # strictDeps = true;
        # nativeBuildInputs = [unzip installShellFiles] ++ lib.optionals stdenvNoCC.isLinux [autoPatchelfHook];
        # buildInputs = [openssl];
        # dontConfigure = true;
        # dontBuild = true;
        # installPhase = ''
        #   runHook preInstall
        #
        #   install -Dm 755 ./bun $out/bin/bun
        #   ln -s $out/bin/bun $out/bin/bunx
        #
        #   runHook postInstall
        # '';
        #
        # postPhases = ["postPatchelf"];
        # postPatchelf = lib.optionalString (stdenvNoCC.buildPlatform.canExecute stdenvNoCC.hostPlatform) ''
        #   completions_dir=$(mktemp -d)
        #
        #   SHELL="bash" $out/bin/bun completions $completions_dir
        #   SHELL="zsh" $out/bin/bun completions $completions_dir
        #   SHELL="fish" $out/bin/bun completions $completions_dir
        #
        #   installShellCompletion --name bun \
        #     --bash $completions_dir/bun.completion.bash \
        #     --zsh $completions_dir/_bun \
        #     --fish $completions_dir/bun.fish
        # '';
        #
        # passthru = {
        #   sources = {
        #     "aarch64-darwin" = fetchurl {
        #       url = "https://github.com/oven-sh/bun/releases/download/bun-v${version}/bun-darwin-aarch64.zip";
        #       hash = "sha256-n5ElTDuD0fap+llzrXN7de937jYaAG8dpJlKUB0npT4=";
        #     };
        #     "aarch64-linux" = fetchurl {
        #       url = "https://github.com/oven-sh/bun/releases/download/bun-v${version}/bun-linux-aarch64.zip";
        #       hash = "sha256-4/kEyaF2kmu8MAjlrPgBqKFDId8bBibu3Zll3b0w8Ro=";
        #     };
        #     "x86_64-darwin" = fetchurl {
        #       url = "https://github.com/oven-sh/bun/releases/download/bun-v${version}/bun-darwin-x64.zip";
        #       hash = "sha256-btyslaKqdk86whAnQV0on7NWTBTRTegFvMsOl0YyloY=";
        #     };
        #     "x86_64-linux" = fetchurl {
        #       url = "https://github.com/oven-sh/bun/releases/download/bun-v${version}/bun-linux-x64.zip";
        #       hash = "sha256-JuDT+8FHbamdMVCDeSTGPYOvhPY2EZ9XeD2zjHEj36Y=";
        #     };
        #   };
        #   updateScript = writeShellScript "update-bun" ''
        #     set -o errexit
        #     export PATH="${lib.makeBinPath [curl jq common-updater-scripts]}"
        #     NEW_VERSION=$(curl --silent https://api.github.com/repos/oven-sh/bun/releases/latest | jq '.tag_name | ltrimstr("bun-v")' --raw-output)
        #     if [[ "${version}" = "$NEW_VERSION" ]]; then
        #         echo "The new version same as the old version."
        #         exit 0
        #     fi
        #     for platform in ${lib.escapeShellArgs meta.platforms}; do
        #       update-source-version "bun" "0" "${lib.fakeHash}" --source-key="sources.$platform"
        #       update-source-version "bun" "$NEW_VERSION" --source-key="sources.$platform"
        #     done
        #   '';
        # };
        # src = pkgs.fetchurl {
        #   url = "https://github.com/htop-dev/htop/releases/download/3.2.1/htop-3.2.1.tar.xz";
        #   sha256 = "sha256-12345..."; # replace with the actual SHA256 hash
        # };
      });
      settings = {
        # smol = true;
        telemetry = false;
        test = {
          coverage = true;
          coverageThreshold = 0.9;
        };
      };
    };
    go = {
      enable = true;
      # packages = {
      # };
    };
  };
  home = {
    packages = with pkgs; [
      # mpv
      # luajit
      notcurses
      # yq-go # yaml processer https://github.com/mikefarah/yq
      flyctl

      ### android ###
      scrcpy

      ### gen ###
      ollama
      llama-cpp

      ### containers ###
      colima
      xquartz

      ### gui apps ###
      # discord
      # vencord

      ### typesetting ###
      glow # markdown previewer in terminal
      typst
      hugo

      sioyek

      # spotifyd

      ### hdl ###
      verilator
      verilog
      gtkwave
      logisim-evolution
      wireshark
      ngspice
      verible
      maven
    ];
  };
}
