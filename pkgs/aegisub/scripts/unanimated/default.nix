{ stdenv, fetchFromGitHub }:

stdenv.mkDerivation rec {
  pname = "unanimated-scripts";
  version = "efc98e26dacf08cd67234c5e569032581ed4849c";

  src = fetchFromGitHub {
    owner = "unanimated";
    repo = "luaegisub";
    rev = version;
    sha256 = "0hzhdhgw8nsgkrfylrksjqhmm668mbs3zxhd1fxx9hk333x6jhiw";
  };

  outputs = [
    "out"
  ] ++ luaScripts;

  luaScripts = [
    "BlurAndGlow"
    "ChangeCase"
    "Colorize"
    "Cycles"
    "EncodeHardsub"
    "FadeWorks"
    "HYDRA"
    "JoinSplitSnap"
    "JumpToNext"
    "LineBreaker"
    "Masquerade"
    "MultiCopy"
    "MultiLineEditor"
    "Multiplexer"
    "NecrosCopy"
    "QC"
    "Recalculator"
    "Relocator"
    "ScriptCleanup"
    "Selectrix"
    "ShiftCut"
    "Significance"
    "TimeSigns"
    "iBus"
  ];

  installPhase = ''
    ${stdenv.lib.concatStringsSep "\n" (builtins.map (output: ''
        mkdir -p ${"$" + output}/share/aegisub/automation/autoload
        cp ua.${output}.lua ${"$" + output}/share/aegisub/automation/autoload/
    '') luaScripts)}
    mkdir -p $out/share/aegisub/automation/autoload
    cp ua.*.lua $out/share/aegisub/automation/autoload/
  '';
}
