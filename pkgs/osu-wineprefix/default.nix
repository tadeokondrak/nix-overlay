{ stdenv, fetchzip, p7zip, pulseaudioSupport ? true }:

fetchzip rec {
  name = "osu-wineprefix";
  url = "https://gitlab.com/osu-wine/osu-wineprefix/raw/master/WINE.win32.7z?inline=false";
  sha256 = if pulseaudioSupport then "0g8b14by0s0wyvkhzm3756g3zq0vv3pfz2r0qpc60k4ml1jhashk"
                                else "1laz2hmqf1q9k9rb62z4b6lm901a6dqgc8p2ipqx4z2glf8kg054";

  postFetch = ''
    ${p7zip}/bin/7z x $downloadedFile
    mv WINE.win32 $out
    rm -rf $out/dosdevices
    rm -rf $out/drive_c/users
    ${stdenv.lib.optionalString (!pulseaudioSupport) "sed -i 's/\"pulse\"/\"alsa\"/g' $out/user.reg"}
    sed -i '/diamond/d' $out/*.reg
    cat >> $out/user.reg << "EOF"

    [Software\\Wine\\DirectSound] 1527486154 5791010
    #time=1d3f646adac9e22
    "HelBuflen"="512"
    "SndQueueMax"="3"
    EOF
  '';

  meta = with stdenv.lib; {
    description = "osu! prebuilt tested wineprefix";
    license = licenses.unfree;
    homepage = https://gitlab.com/osu-wine/osu-wineprefix;
    maintainers = with maintainers; [ tadeokondrak ];
    platforms = platforms.all;
  };
}

