{ stdenv, fetchFromGitHub, pkgconfig, alsaLib, sndio }:

stdenv.mkDerivation rec {
  pname = "alsa-sndio";
  version = "0.2";

  nativeBuildInputs = [ pkgconfig ];
  buildInputs = [ sndio alsaLib ];
  installFlags = [ "DESTDIR=$(out)" "PREFIX=" ];

  src = fetchFromGitHub {
    owner = "Duncaen";
    repo = pname;
    rev = version;
    sha256 = "01yvbdskfgfg5nvd7fm759gd54x2y6v0r90j7n0acdc7r4iwv75d";
  };

  meta = with stdenv.lib; {
    description = "ALSA PCM to play audio on sndio servers";
    homepage = https://github.com/duncaen/alsa-sndio;
    license = licenses.isc;
    maintainers = with maintainers; [ tadeokondrak ];
    platforms = platforms.linux;
  };
}
