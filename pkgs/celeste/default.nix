{ stdenv, requireFile, autoPatchelfHook, unzip, makeWrapper, gcc-unwrapped, zlib, libGL, xorg, alsaLib, libudev0-shim }:

stdenv.mkDerivation rec {
  pname = "celeste";
  version = "1.2.5.3";

  src = requireFile {
    url = meta.downloadPage;
    name = "celeste-linux-${version}.zip";
    sha256 = "336df72929de6bcf333719864085ac302316e85735c386f2e646e4c58ad5ecf6";
  };

  sourceRoot = ".";

  nativeBuildInputs = [
    unzip
    autoPatchelfHook
    makeWrapper
  ];

  buildInputs = [
    gcc-unwrapped.lib
    zlib
  ];

  binaryName = "Celeste.bin.${if stdenv.targetPlatform.system == "i686-linux" then "x86" else "x86_64"}";

  libPath = "$out/opt/Celeste/${if stdenv.targetPlatform.system == "i686-linux" then "lib" else "lib64"}";

  libPathExtra = stdenv.lib.makeLibraryPath [
    libGL
    xorg.libXinerama
    alsaLib
    libudev0-shim
  ];

  installPhase = ''
    mkdir -p $out/opt/Celeste $out/bin
    mv * $out/opt/Celeste
    makeWrapper $out/opt/Celeste/${binaryName} $out/bin/celeste \
        --prefix LD_LIBRARY_PATH : "${libPath}:${libPathExtra}"
  '';


  meta = with stdenv.lib; {
    description = "A game about climbing a mountain";
    homepage = http://www.celestegame.com/;
    downloadPage = https://mattmakesgames.itch.io/celeste;
    license = licenses.unfree;
    maintainers = with maintainers; [ tadeokondrak ];
    platforms = [ "i686-linux" "x86_64-linux" ];
  };
}
