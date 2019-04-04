{ stdenv, fetchFromGitHub, makeWrapper, qmake, qtbase, qtwebengine, qtwayland }:

stdenv.mkDerivation rec {
  pname = "discord-player";
  version = "dc54efa94ea840828e98df8f169540377f9bfd67";

  src = fetchFromGitHub {
    owner = "mintsuki";
    repo = pname;
    rev = version;
    sha256 = "06wgy52yf13n4568jc55rvl22yzhmcajhvzqk11a6q4m5xfgfr3k";
  };

  nativeBuildInputs = [ qmake makeWrapper ];
  buildInputs = [ qtbase qtwebengine ];

  installPhase = ''
    install -D discord-player $out/bin/discord-player
    wrapProgram $out/bin/discord-player \
        --prefix LD_LIBRARY_PATH : ${qtwayland}/lib
  '';

  meta = with stdenv.lib; {
    description = "QtWebEngine wrapper for Discord";
    homepage = https://github.com/mintsuki/discord-player;
    license = licenses.bsd2;
    maintainers = [ maintainers.tadeokondrak ];
    platforms = platforms.linux; # macOS/Darwin is possible
  };
}
