self: super: {
  alsa-sndio = super.callPackage ./pkgs/alsa-sndio { };
  aucatctl = super.callPackage ./pkgs/aucatctl { };
  beautifuldiscord = super.callPackage ./pkgs/beautifuldiscord { };
  betterdiscordctl = super.callPackage ./pkgs/betterdiscordctl { };
  btpd = super.callPackage ./pkgs/btpd { };
  caprine = super.callPackage ./pkgs/caprine { };
  glpaper = super.callPackage ./pkgs/glpaper { };
  celeste = super.callPackage ./pkgs/celeste { };
  cemu = super.libsForQt5.callPackage ./pkgs/cemu { };
  cum = super.callPackage ./pkgs/cum { };
  discord-player = super.libsForQt511.callPackage ./pkgs/discord-player { };
  discord-rpc = super.callPackage ./pkgs/discord-rpc { };
  discord-rpc-wine = super.callPackage ./pkgs/rpc-wine { };
  discord-rpc-wine-32 = super.pkgsi686Linux.callPackage ./pkgs/rpc-wine { };
  gogextract = super.callPackage ./pkgs/gogextract { };
  ix = super.libsForQt5.callPackage ./pkgs/ix { };
  kiwmi = super.callPackage ./pkgs/kiwmi { };
  mocha = super.callPackage ./pkgs/mocha { };
  mpd-rich-presence-discord = super.callPackage ./pkgs/mpd-rich-presence-discord { };
  mydiscord = super.callPackage ./pkgs/mydiscord { };
  oppai-ng = super.callPackage ./pkgs/oppai-ng { };
  libmfao = super.callPackage ./pkgs/libmfao { };
  pyvizio = super.callPackage ./pkgs/pyvizio { };
  osu-pp = super.callPackage ./pkgs/osu-pp { };
  osu-wine = super.callPackage ./pkgs/osu-wine { };
  osu-wineprefix = super.callPackage ./pkgs/osu-wineprefix { };
  pythOCR = super.callPackage ./pkgs/pythOCR { };
  sciter = super.callPackage ./pkgs/sciter { };
  shenzhen-io = super.callPackage ./pkgs/shenzhen-io{ };
  sndio = super.callPackage ./pkgs/sndio { };
  vapoursynth-plugins = super.callPackage ./pkgs/vapoursynth-plugins { };
  w3 = super.callPackage ./pkgs/w3 { };
  windowchef = super.callPackage ./pkgs/windowchef { };

  discord-css = super.callPackage ./pkgs/discord-css {
    cssFile = (super.writeText "discord.css" "");
  };

  wine-osu = super.wineStaging.overrideDerivation (self: rec {
    winealsa_patch = super.fetchpatch ({
      url = "https://aur.archlinux.org/cgit/aur.git/plain/winealsa_latency.patch?h=wine-osu";
      sha256 = "1sv7lx5hahfiyk7y466mn3xx1mb5qw396lpgwg9a97l9aqk30ql5";
    });
    # winepulse_patch = super.fetchpatch {
    #   url = "https://aur.archlinux.org/cgit/aur.git/plain/winepulse_latency.patch?h=wine-osu";
    #   sha256 = "1rb8zp2vkn1jm3fr6f72z8rvkjlfnifb1dfy6hndxqs4354izmx8";
    # };
    postPatch = self.postPatch or "" + ''
      patch -Np1 < ${winealsa_patch}
      # patch -Np1 < $'''{winepulse_patch}
    '';
  });

  vapoursynth = super.vapoursynth.overrideAttrs (self: {
    buildInputs = self.buildInputs ++ (with super; [ makeWrapper python3 ]);
    postInstall = ''
      wrapProgram $out/bin/vspipe --prefix PYTHONPATH : "$(toPythonPath $out)"
    '';
  });
}
