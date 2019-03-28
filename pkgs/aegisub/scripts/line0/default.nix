{ stdenv, fetchFromGitHub }:

stdenv.mkDerivation rec {
  pname = "line0-scripts";
  version = "548c4b70f25aa8a2c873f41d6116388c50f8da7c";

  src = fetchFromGitHub {
    owner = "TypesettingTools";
    repo = "line0-aegisub-scripts";
    rev = version;
    sha256 = "0ykmx1lrrs6ak8qvq6p8gx7a9hgvipaymfnqk94rbh0ksdpxd1c8";
  };

  outputs = [
    "out"
  ] ++ moonScripts;

  moonScripts = [
    "ASSWipe"
    "CascadeTransforms"
    "HighlightSubstring"
    "InsertLineBreaks"
    "MergeDrawings"
    "MoveAlongPath"
    "Nudge"
    "PasteAiLines"
    "ShakeIt"
    "SplitLines"
    "VerticalText"
  ];

  installPhase = ''
    ${stdenv.lib.concatStringsSep "\n" (builtins.map (output: ''
        mkdir -p ${"$" + output}/share/aegisub/automation/autoload
        cp l0.${output}.moon ${"$" + output}/share/aegisub/automation/autoload/
    '') moonScripts)}
    mkdir -p $out/share/aegisub/automation/autoload
    cp l0.*.moon $out/share/aegisub/automation/autoload/
  '';
}
