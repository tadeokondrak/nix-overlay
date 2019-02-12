{ stdenv, fetchurl, sndio, libbsd }:

stdenv.mkDerivation rec {
  pname = "aucatctl";
  version = "0.1";

  buildInputs = [ sndio libbsd ];
  makeFlags = [ "LDADD=-lbsd" "LDADD+=-lsndio" ];
  installFlags = [ "DESTDIR=$(out)" "PREFIX=" ];

  src = fetchurl {
    url = "http://www.sndio.org/${pname}-${version}.tar.gz";
    sha256 = "1w3c4k70jdbyh2yki90walkrlnv0v4h1amb6y4s54y6v8yp2yksj";
  };

  meta = with stdenv.lib; {
    description = "Control sndiod and/or aucat volumes";
    homepage = http://www.sndio.org/;
    license = licenses.isc;
    maintainers = with maintainers; [ tadeokondrak ];
    platforms = platforms.all;
  };
}
