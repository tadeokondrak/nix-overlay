{ stdenv, fetchFromBitbucket, writeText, vapoursynth, qmake, qtbase, qtwebsockets }:

stdenv.mkDerivation rec {
  pname = "vapoursynth-editor";
  version = "R19";

  src = fetchFromBitbucket {
    owner = "mystery_keeper";
    repo = pname;
    rev = stdenv.lib.toLower version;
    sha256 = "1zlaynkkvizf128ln50yvzz3b764f5a0yryp6993s9fkwa7djb6n";
  };

  nativeBuildInputs = [ qmake ];
  buildInputs = [ qtbase vapoursynth qtwebsockets ];

  NIX_LDFLAGS = ''
    -rpath ${vapoursynth.out}/lib
  '';

  preConfigure = ''
    cd pro
  '';

  installPhase = ''
    cd ../build/release*
    mkdir -p $out/bin
    cp vsedit{,-job-server{,-watcher}} $out/bin
  '';
}
