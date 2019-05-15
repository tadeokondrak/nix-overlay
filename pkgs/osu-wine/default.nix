{ stdenv, writers, bash, wine, wget, coreutils, findutils, osu-wineprefix, discord-rpc-wine }:

(writers.writeBashBin "osu" ''
  set -e
  prefixsrc="${osu-wineprefix}"
  basedir="''${XDG_DATA_HOME:-$HOME/.local/share}/osu-wine"
  osudir="$basedir/osu"

  PATH="${stdenv.lib.makeSearchPath "bin" [ wine wget coreutils findutils ]}:$PATH"

  export WINEARCH="win32"
  export WINEPREFIX="$basedir/prefix_$WINEARCH"
  export WINEDEBUG="-all"
  export WINEDLLPATH="${discord-rpc-wine}/lib/wine"''${WINEDLLPATH:+':'}$WINEDLLPATH
  export WINEDLLOVERRIDES="discord-rpc"

  mkdir -p "$basedir" "$osudir" "$WINEPREFIX"

  touch "$basedir/.prefixsrc"

  [[ $prefixsrc != $(cat "$basedir/.prefixsrc") ]] && {
      echo "Creating wineprefix..."

      chmod -R 755 "$WINEPREFIX"
      rm -rf "$WINEPREFIX"
      rm -rf "$basedir/home"

      mkdir "$WINEPREFIX"

      cp $prefixsrc/*.reg "$WINEPREFIX"

      mkdir -p "$WINEPREFIX/drive_c"
      ln -s "$prefixsrc/drive_c/"* "$WINEPREFIX/drive_c/"

      mkdir -p "$WINEPREFIX/dosdevices"
      ln -s "../drive_c" "$WINEPREFIX/dosdevices/c:"
      ln -s "../../osu" "$WINEPREFIX/dosdevices/x:"

      echo "$prefixsrc" > "$basedir/.prefixsrc"

      echo "If you see an error about how the program can't be started, hit OK or No (twice)."

      wineboot -u
  }

  [ ! -f "$osudir/osu!.exe" ] && {
      wget "https://m1.ppy.sh/r/osu!install.exe" -O "$osudir/osu!.exe"
  }

  if [ -f "$1" ] && [[ "$1" =~ .*\.(osz|osz2|osr|osk) ]]; then
      FILE="$1"; shift
      mv -- "$FILE" "$osudir/Temp"
      exec wine "X:\\osu!.exe" "X:\\Temp\\$(basename -- "$FILE")" "$@"
  else
      exec wine "X:\\osu!.exe" "$@"
  fi
'') // {
  meta = with stdenv.lib; {
    description = "osu! wine installer";
    license = licenses.mit;
    maintainers = with maintainers; [ tadeokondrak ];
    platforms = [ "i686-linux" "x86_64-linux" ];
  };
}
