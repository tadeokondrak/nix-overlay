{ stdenv, fetchFromGitHub, qmake, qtbase, qtwebengine }:

stdenv.mkDerivation rec {
  pname = "discord-player";
  version = "dc54efa94ea840828e98df8f169540377f9bfd67";

  src = fetchFromGitHub {
    owner = "mintsuki";
    repo = pname;
    rev = version;
    sha256 = "06wgy52yf13n4568jc55rvl22yzhmcajhvzqk11a6q4m5xfgfr3k";
  };

  nativeBuildInputs = [ qmake ];
  buildInputs = [ qtbase qtwebengine ];

  installPhase = ''
    install -D discord-player $out/bin/discord-player
  '';

  meta = with stdenv.lib; {
    description = "QtWebEngine wrapper for Discord";
    homepage = https://github.com/mintsuki/discord-player;
    license = licenses.bsd2;
    maintainers = [ maintainers.tadeokondrak ];
    platforms = platforms.linux; # macOS/Darwin is possible
  };
}
