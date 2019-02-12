{ stdenv, fetchFromGitHub, nasm, yasm, pkgconfig, automake, autoconf, libtool, libpng, libsndfile, boost, opencv, libbluray, zlib, ocl-icd, opencl-headers, xvidcore }:

stdenv.mkDerivation rec {
  pname = "vapoursynth-plugins";
  version = "20180501";

  src = fetchFromGitHub {
    owner = "darealshinji";
    repo = pname;
    rev = "614d367e826b5f6bb0af33e1f91453f3ff7999ec";
    sha256 = "12447sdlf1brjx9cp40pbbw2c3pfrzsq3wzrifc80m6cz2k40w5n";
  };

  ffmpegSrc = fetchFromGitHub {
    owner = "FFmpeg";
    repo = "FFmpeg";
    rev = "n3.4.4";
    sha256 = "1ijn3w38pch0byim2i19sn1lalkgm0z9sfjyk94v0n9b68jzijh8";
  };

  buildInputs = [ pkgconfig libtool automake autoconf boost opencv
                  libbluray zlib ocl-icd opencl-headers nasm yasm
                  xvidcore opencv libpng libsndfile ];

  preConfigure = ''
    rm -rf plugins/lsmashsource # TODO: get this to work
    cp -dr ${ffmpegSrc} ffmpeg
    chmod -R +w ffmpeg
    ./autogen.sh
  '';
}
