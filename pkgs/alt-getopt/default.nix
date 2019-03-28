{ luaPackages, fetchurl }:

luaPackages.buildLuarocksPackage rec {
  pname = "alt-getopt";
  version = "0.8.0";

  src = fetchurl {
    url = "https://luarocks.org/manifests/mpeterv/alt-getopt-0.8.0-1.src.rock";
    sha256 = "1mi97dqb97sf47vb6wrk12yf1yxcaz0asr9gbgwyngr5n1adh5i3";
  };
}
