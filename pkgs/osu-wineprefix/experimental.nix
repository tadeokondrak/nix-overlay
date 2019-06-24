{ stdenv, writeText, xorgserver, wine, winetricks }:

stdenv.mkDerivation {
  name = "wineprefix-osu";

  outputHashAlgo = "sha256";
  outputHashMode = "recursive";
  outputHash = "1224dln7n8px1rk8biiggf77wjhxh8mzw0hd8zlyjm8i6j8w7i12";

  unpackPhase = ":";

  regedit = writeText "edit.reg" ''
    Windows Registry Editor Version 5.00

    [HKEY_CURRENT_USER\Software\Wine\DllOverrides]
    "discord-rpc"="builtin"

    [HKEY_CURRENT_USER\Software\Wine\DirectSound]
    "HelBuflen"="512"
    "SndQueueMax"="3"
  '';

  buildInputs = [ xorgserver wine winetricks ];

  buildPhase = ''
    Xvfb -once -reset -terminate :0 &
    export DISPLAY=:0

    mkdir $out
    export WINEARCH=win32
    export WINEPREFIX=$out
    export WINEDLLOVERRIDES="mscoree,mshtml=" # disable popup for mono and gecko
    export WINEDEBUG=-all
    export HOME=$(mktemp -d)
    export SSL_CERT_FILE=/etc/ssl/certs/ca-bundle.crt
    wineboot -u

    winetricks dotnet40
    winetricks dotnet45

    wineserver -w

    rm -rf $WINEPREFIX/{users,dosdevices}
  '';
  meta = with stdenv.lib; {
    license = licenses.unfree;
    maintainers = with maintainers; [ tadeokondrak ];
    platforms = platforms.linux;
    broken = !stdenv.isi686;
  };
}
