{ stdenv, fetchFromGitHub }:

stdenv.mkDerivation rec {
  pname = "assfoundation";
  version = "0.4.2";

  src = fetchFromGitHub {
    owner = "TypesettingTools";
    repo = "ASSFoundation";
    rev = "v${version}";
    sha256 = "07mj5yf2m1znmcgs1bnxgay0zazbwygrlzgv16ybhzi9kb1mra0i";
  };

  installPhase = ''
   mkdir -p $out/share/aegisub/automation/include
   mv l0 $out/share/aegisub/automation/include/
 '';
}
