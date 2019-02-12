{ stdenv, writeScript, bash, wine, wget, coreutils, findutils, osu-wineprefix }:

stdenv.mkDerivation rec {
  pname = "osu-wine";
  version = "0.1.0";
  name = "${pname}-${version}";

  buildInputs = [ bash ];
  path = stdenv.lib.makeSearchPath "bin" [ wine wget coreutils findutils ];

  src = writeScript "osu" ''
    #!/usr/bin/env bash
    set -e
    PATH="${path}"
    PREFIXSRC="${osu-wineprefix}"
    BASEDIR="$HOME/.local/share/osu-wine"
    OSUDIR="$BASEDIR/osu"
    export WINEARCH="win32"
    export WINEPREFIX="$BASEDIR/prefix_$WINEARCH"
    export WINEDEBUG="-all"

    mkdir -p "$BASEDIR" "$OSUDIR" "$WINEPREFIX"

    touch "$BASEDIR/.prefixsrc"

    [ "$PREFIXSRC" != "$(cat "$BASEDIR/.prefixsrc")" ] || [ ! -d "$WINEPREFIX" ] && {
        echo "Creating wineprefix..."

        chmod -R 755 "$WINEPREFIX"
        rm -rf "$WINEPREFIX"
        rm -rf "$BASEDIR/home"

        mkdir "$WINEPREFIX"

        cp $PREFIXSRC/{*.sig,*.reg} "$WINEPREFIX"

        mkdir -p "$WINEPREFIX/drive_c"
        ln -s "$PREFIXSRC/drive_c/"* "$WINEPREFIX/drive_c/"

        mkdir -p "$WINEPREFIX/dosdevices"
        ln -s "../drive_c" "$WINEPREFIX/dosdevices/c:"
        ln -s "../../osu" "$WINEPREFIX/dosdevices/x:"

        echo "$PREFIXSRC" > "$BASEDIR/.prefixsrc"

        echo "If you see an error about how the program can't be started, hit no."

        wineboot -u
    }

    [ ! -f "$OSUDIR/osu!.exe" ] && {
        wget "https://m1.ppy.sh/r/osu!install.exe" -O "$OSUDIR/osu!.exe"
    }

    if [ -f "$1" ] && [[ "$1" =~ .*\.(osz|osz2|osr|osk) ]]; then
        FILE="$1"; shift
        mv -- "$FILE" "$OSUDIR/Temp"
        exec wine "X:\\osu!.exe" "X:\\Temp\\$(basename -- "$FILE")" "$@"
    else
        exec wine "X:\\osu!.exe" "$@"
    fi
  '';

  unpackPhase = ''
    cp $src osu
  '';

  installPhase = ''
    install -D osu $out/bin/osu
  '';

  meta = with stdenv.lib; {
    description = "osu! wine installer";
    license = licenses.mit;
    maintainers = with maintainers; [ tadeokondrak ];
    platforms = [ "i686-linux" "x86_64-linux" ];
  };
}
