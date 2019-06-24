{ stdenv, writers, bash, wine, wget, coreutils, gnused, osu-wineprefix, discord-rpc-wine-32 }:

(writers.writeBashBin "osu" ''
  set -e
  prefixsrc="${osu-wineprefix}"
  basedir="''${XDG_DATA_HOME:-$HOME/.local/share}/osu-wine"
  cfgdir="''${XDG_CONFIG_HOME:-$HOME/.config}/osu-wine"
  osudir="$basedir/osu"

  PATH="${stdenv.lib.makeSearchPath "bin" [ wine wget coreutils gnused ]}:$PATH"

  export WINEARCH="win32"
  export WINEPREFIX="$basedir/prefix_$WINEARCH"
  export WINEDEBUG="''${WINEDEBUG:--all}"
  export WINEDLLPATH="${discord-rpc-wine-32}/lib/wine"''${WINEDLLPATH:+':'}$WINEDLLPATH
  export WINEDLLOVERRIDES="discord-rpc=b"''${WINEDLLOVERRIDES:+','}$WINEDLLOVERRIDES

  mkdir -p "$basedir" "$osudir" "$WINEPREFIX"

  mkdir -p "$osudir/temp" "$osudir/userprofile"
  export TEMP="X:\\temp"
  export USERPROFILE="X:\\userprofile"

  touch "$basedir/.prefixsrc"

  [[ ! -f "$basedir/.prefixsrc" || $prefixsrc != $(cat "$basedir/.prefixsrc") ]] && {
      echo "Creating wineprefix..."

      rm -rf "$WINEPREFIX"
      mkdir "$WINEPREFIX"

      cp $prefixsrc/*.reg "$WINEPREFIX"
      sed -i 's/C:\\\\windows\\\\temp/X:\\\\Temp/g' "$WINEPREFIX/system.reg"

      ln -s "$prefixsrc/drive_c" "$WINEPREFIX"

      mkdir -p "$WINEPREFIX/dosdevices"
      ln -s "../drive_c" "$WINEPREFIX/dosdevices/c:"
      ln -s "../../osu" "$WINEPREFIX/dosdevices/x:"

      echo "$prefixsrc" > "$basedir/.prefixsrc"

      echo "If you see an error about how the program can't be started, hit OK or No (twice)."

      wineboot -u
  }

  [[ ! -f $osudir/osu!.exe ]] &&
      wget "https://m1.ppy.sh/r/osu!install.exe" -O "$osudir/osu!.exe"

  [[ -d $cfgdir ]] &&
      cp -fv "$cfgdir/osu!."*.cfg "$osudir"

  [[ -d "$cfgdir/skins" ]] &&
      ln -sf "$cfgdir/skins/"* "$osudir/Skins"

  if [ -f "$1" ] && [[ "$1" =~ .*\.(osz|osz2|osr|osk) ]]; then
      FILE="$1"; shift
      mkdir -p "$osudir/Temp"
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
