{ stdenv, fetchurl, dpkg, makeDesktopItem, autoPatchelfHook, wrapGAppsHook
, alsaLib, atk, at-spi2-atk, cairo, cups, dbus, expat, fontconfig, freetype, gdk_pixbuf
, glib, gtk3, libnotify, libX11, libXcomposite, libXcursor, libXdamage, libuuid
, libXext, libXfixes, libXi, libXrandr, libXrender, libXtst, nspr, nss, libxcb
, pango, systemd, libXScrnSaver, libcxx, libpulseaudio }:

stdenv.mkDerivation rec {
  pname = "caprine";
  version = "2.28.0";

  src = fetchurl {
    url = "https://github.com/sindresorhus/caprine/releases/download/v${version}/caprine_${version}_amd64.deb";
    sha256 = "0whl7w2fdyn3q22yn662nl12j4xwch5l9n1pycv7g9whqxr27vs9";
  };

  nativeBuildInputs = [ dpkg wrapGAppsHook ];

  dontWrapGApps = true;

  libPath = stdenv.lib.makeLibraryPath [
    libcxx systemd libpulseaudio
    stdenv.cc.cc alsaLib atk at-spi2-atk cairo cups dbus expat fontconfig freetype
    gdk_pixbuf glib gtk3 libnotify libX11 libXcomposite libuuid
    libXcursor libXdamage libXext libXfixes libXi libXrandr libXrender
    libXtst nspr nss libxcb pango systemd libXScrnSaver
  ];

  unpackPhase = ''
    dpkg-deb -x $src .
  '';

  installPhase = ''
    mkdir -p $out/{share,bin,opt}
    mv opt/* $out/opt

    patchelf --set-interpreter ${stdenv.cc.bintools.dynamicLinker} \
         $out/opt/Caprine/caprine

    makeWrapper $out/opt/Caprine/caprine $out/bin/caprine \
        "''${gappsWrapperArgs[@]}" \
        --prefix XDG_DATA_DIRS : "${gtk3}/share/gsettings-schemas/${gtk3.name}/" \
        --prefix LD_LIBRARY_PATH : ${libPath}

    mv usr/share/icons $out/share/
    ln -s "${desktopItem}/share/applications" $out/share/
  '';

  desktopItem = makeDesktopItem {
    name = pname;
    desktopName = "Caprine";
    comment = meta.description;
    exec = "${pname} %U";
    terminal = "false";
    type = "Application";
    icon = pname;
    categories = "Network;Chat;";
    extraEntries = ''
      StartupWMClass=Caprine
    '';
  };

  meta = with stdenv.lib; {
    description = "An unofficial and privacy focused Facebook Messenger app with many useful features";
    homepage = https://sindresorhus.com/caprine/;
    downloadPage = https://github.com/sindresorhus/caprine/releases/latest;
    license = licenses.unfree;
    maintainers = with maintainers; [ tadeokondrak ];
    platforms = [ "x86_64-linux" ];
  };
}
