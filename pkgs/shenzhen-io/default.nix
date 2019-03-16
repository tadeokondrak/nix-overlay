{ stdenv, requireFile, gogextract, unzip, autoPatchelfHook, makeWrapper, gcc-unwrapped, zlib, libGL, xorg, alsaLib, libudev0-shim }:

stdenv.mkDerivation rec {
  pname = "shenzhen-io";
  version = "13.02";

  src = requireFile {
    url = meta.downloadPage;
    name = "shenzhen_io_en_13_02_18613.sh";
    sha256 = "cdecab5e814e8ffc759c4104d489bdd77f6a1f359f9e2d1ec9354f541f5cfbeb";
  };

  # gog pls
  unpackPhase = ''
    ${gogextract}/bin/gogextract $src .
    ${unzip}/bin/unzip data.zip
    mv data/noarch/game/* .
    rm -rf data meta scripts mojosetup.tar.gz unpacker.sh
  '';

  nativeBuildInputs = [
    autoPatchelfHook
    makeWrapper
  ];

  buildInputs = [
    gcc-unwrapped.lib
    zlib
  ];

  binaryName = "Shenzhen.bin.${if stdenv.targetPlatform.system == "i686-linux" then "x86" else "x86_64"}";

  libPath = "$out/opt/Shenzhen/${if stdenv.targetPlatform.system == "i686-linux" then "lib" else "lib64"}";

  libPathExtra = stdenv.lib.makeLibraryPath [
    libGL
    xorg.libXinerama
    alsaLib
    libudev0-shim
  ];

  installPhase = ''
    mkdir -p $out/opt/Shenzhen $out/bin
    mv * $out/opt/Shenzhen
    makeWrapper $out/opt/Shenzhen/${binaryName} $out/bin/shenzhenio \
        --prefix LD_LIBRARY_PATH : "${libPath}:${libPathExtra}"
  '';


  meta = with stdenv.lib; {
    #description = "A game about climbing a mountain";
    #homepage = http://www.celestegame.com/;
    #downloadPage = https://mattmakesgames.itch.io/celeste;
    #license = licenses.unfree;
    #maintainers = with maintainers; [ tadeokondrak ];
    #platforms = [ "i686-linux" "x86_64-linux" ];
    broken = true;
  };
}
