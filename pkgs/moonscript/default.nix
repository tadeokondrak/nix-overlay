{ luaPackages, fetchurl, alt-getopt }:

luaPackages.buildLuarocksPackage rec {
  pname = "moonscript";
  version = "0.5.0";

  src = fetchurl {
    url = "https://luarocks.org/manifests/leafo/moonscript-0.5.0-1.src.rock";
    sha256 = "09vv3ayzg94bjnzv5fw50r683ma0x3lb7sym297145zig9aqb9q9";
  };

  buildInputs = (with luaPackages; [ lpeg luafilesystem ]) ++ [ alt-getopt ];
}
