{ stdenv, fetchurl, alsaLib }:

stdenv.mkDerivation rec {
  name = "sndio-${version}";
  version = "1.5.0";

  src = fetchurl {
    url = "http://www.sndio.org/sndio-${version}.tar.gz";
    sha256 = "0lyjb962w9qjkm3yywdywi7k2sxa2rl96v5jmrzcpncsfi201iqj";
  };

  buildInputs = [ alsaLib ];

  meta = with stdenv.lib; {
    description = "Small audio and MIDI framework part of the OpenBSD project";
    homepage = http://www.sndio.org/;
    license = licenses.isc;
    maintainers = with maintainers; [ tadeokondrak ];
    platforms = platforms.all;
  };
}
