{ stdenv, fetchurl, rapidjson, wineWowPackages }:

stdenv.mkDerivation rec {
  pname = "rpc-wine";
  version = "1.0.0";
  src = fetchurl {
    url = "https://github.com/Marc3842h/${name}/archive/${version}.tar.gz";
    sha256 = "18jfg5ws2xykvvkblyq3frp9x5rjpvm7hfa6cb0mr7865b6fd350";
  };
  nativeBuildInputs = [ wineWowPackages.stable ];
  buildInputs = [ rapidjson ];
  buildPhase = ''
    bash build.sh --skip-32-bit
  '';
  installPhase = ''
    install bin64/discord-rpc.dll.so -D $out/lib/wine/discord-rpc.dll.so
  '';
}
