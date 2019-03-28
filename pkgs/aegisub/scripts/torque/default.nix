{ stdenv, fetchFromGitHub }:

stdenv.mkDerivation rec {
  pname = "torque-scripts";
  version = "47f9717684107cacf9003e7cdafbace48a213415";

  src = fetchFromGitHub {
    owner = "TypesettingTools";
    repo = "torques-dumb-script-dump";
    rev = version;
    sha256 = "0r3fkdf0f82rz302d08ix8hlkm9h7p38n2ivkxmfhman785pgmjx";
  };

  outputs = [
    "out"
  ] ++ scripts;

  scripts = [
    "boundingboxes"
    "joinlines"
    "shiftsubs"
  ];

  installPhase = ''
    ${stdenv.lib.concatStringsSep "\n" (builtins.map (output: ''
        mkdir -p ${"$" + output}/share/aegisub/automation/autoload
        cp ${output}.moon ${"$" + output}/share/aegisub/automation/autoload/
    '') scripts)}
    mkdir -p $out/share/aegisub/automation/autoload
    ln -s {${"$" + stdenv.lib.concatStringsSep ",$" (scripts)}}/share/aegisub/automation/autoload/* \
        $out/share/aegisub/automation/autoload/
  '';
}
