{ stdenv, fetchFromGitHub }:

stdenv.mkDerivation rec {
  pname = "oppai-ng";
  version = "3.2.0";

  src = fetchFromGitHub {
    owner = "Francesco149";
    repo = pname;
    rev = version;
    sha256 = "1alsdn1ghcp8jma2w7waljlcxr445kj85az3q92klvkyayc19413";
  };

  buildPhase = ''
    ./build
    ./libbuild
  '';

  installPhase = ''
    install -D oppai $out/bin/oppai
    install -D oppai.c $out/include/oppai.c
    install -D liboppai.so $out/lib/liboppai.so
  '';

  meta = with stdenv.lib; {
    description = "difficulty and pp calculator for osu!";
    homepage = https://github.com/Francesco149/oppai-ng;
    license = licenses.unlicense;
    maintainers = with maintainers; [ tadeokondrak ];
    platform = platforms.all;
  };
}
