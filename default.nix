self: super: rec {
  ircdiscord = super.callPackage ./pkgs/ircdiscord { };
  wl-clipboard-x11 = super.callPackage ./pkgs/wl-clipboard-x11 { };
  #aegisub = super.callPackage ./pkgs/aegisub { };
  #alsa-sndio = super.callPackage ./pkgs/alsa-sndio { };
  #aucatctl = super.callPackage ./pkgs/aucatctl { };
  beautifuldiscord = super.callPackage ./pkgs/beautifuldiscord { };
  betterdiscordctl = super.callPackage ./pkgs/betterdiscordctl { };
  btpd = super.callPackage ./pkgs/btpd { };
  caprine = super.callPackage ./pkgs/caprine { };
  celeste = super.callPackage ./pkgs/celeste { };
  cemu = super.libsForQt5.callPackage ./pkgs/cemu { };
  custard = super.callPackage ./pkgs/custard { };
  discord-player = super.libsForQt511.callPackage ./pkgs/discord-player { };
  discord-rpc-wine = super.callPackage ./pkgs/rpc-wine { };
  discord-rpc-wine-32 = super.pkgsi686Linux.callPackage ./pkgs/rpc-wine { };
  glpaper = super.callPackage ./pkgs/glpaper { };
  gogextract = super.callPackage ./pkgs/gogextract { };
  ix = super.libsForQt5.callPackage ./pkgs/ix { };
  kiwmi = super.callPackage ./pkgs/kiwmi { };
  libmfao = super.callPackage ./pkgs/libmfao { };
  mocha = super.callPackage ./pkgs/mocha { };
  mpd-rich-presence-discord = super.callPackage ./pkgs/mpd-rich-presence-discord { };
  mydiscord = super.callPackage ./pkgs/mydiscord { };
  osu-wine = super.callPackage ./pkgs/osu-wine { };
  osu-wineprefix = super.callPackage ./pkgs/osu-wineprefix{ };
  osu-wineprefix-exp = super.pkgsi686Linux.callPackage ./pkgs/osu-wineprefix/experimental.nix{ };
  pythOCR = super.callPackage ./pkgs/pythOCR { };
  pyvizio = super.callPackage ./pkgs/pyvizio { };
  reopen = super.callPackage ./pkgs/reopen { };
  rootbar = super.callPackage ./pkgs/rootbar { };
  sciter = super.callPackage ./pkgs/sciter { };
  shenzhen-io = super.callPackage ./pkgs/shenzhen-io{ };
#  vapoursynth-editor = super.libsForQt5.callPackage ./pkgs/vapoursynth-editor { };
  vapoursynth-plugins = super.callPackage ./pkgs/vapoursynth-plugins { };
  w3 = super.callPackage ./pkgs/w3 { };
  windowchef = super.callPackage ./pkgs/windowchef { };
  wlr-randr = super.callPackage ./pkgs/wlr-randr { };

  moonscript = super.callPackage ./pkgs/moonscript {
    alt-getopt = super.callPackage ./pkgs/alt-getopt { };
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
}
