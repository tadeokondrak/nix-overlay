{ stdenv, lib, fetchFromGitHub, vapoursynth-plugins, python3Packages, tesseract3, python3, makeWrapper, vapoursynth, ffms, enchant }:

with lib;

stdenv.mkDerivation rec {
  name = "pythOCR";
  version = "20181104";
  src = fetchFromGitHub {
    owner = "pocketsnizort";
    repo = name;
    rev = "5bf03c6c2cf0ce8cdb546dbbfa2399a6c8e7d1ba";
    sha256 = "0k5v9ljk7ghd0hvqddk67yv9x30i236ly3zinrspbsnpfns7qfnw";
  };
  buildInputs = [ makeWrapper ];
  propagatedBuildInputs = with python3Packages; [ colorama ConfigArgParse pyenchant enchant numpy opencv3 tqdm ];
  installPhase = ''
    install -D pythoCR.py $out/bin/pythocr
    sed -i '1i#!${python3.withPackages (_: propagatedBuildInputs)}/bin/python' $out/bin/pythocr
    wrapProgram $out/bin/pythocr \
      --prefix PATH : "${vapoursynth}/bin:${tesseract3}/bin" \
      --prefix PYTHONPATH : "${vapoursynth-plugins}/lib/python3/dist-packages/vsscripts" \
      --prefix LD_LIBRARY_PATH : "${vapoursynth-plugins}/lib" # doesn't work
 '';
}
