{ stdenv, fetchFromGitHub, installAegisubScript, moonscript, perl }:

stdenv.mkDerivation rec {
  pname = "aegisub-motion";
  version = "1.0.6";

  src = fetchFromGitHub {
    owner = "TypesettingTools";
    repo = "Aegisub-Motion";
    rev = "v${version}";
    sha256 = "16isjw6m8syicazikjyvmh3cdf90d7cwi56dzhn6wj4dw68n0zyn";
  };

  buildInputs = [ moonscript perl ];

  buildPhase = ''
    moon VersionDetemplater.moon
  '';

  outputs = [
    "out"
  ] ++ macros
    ++ modules;

  macros = [
    "AegisubMotion"
  ];

  modules = [
    "ConfigHandler"
    "DataHandler"
    "DataWrapper"
    "Line"
    "LineCollection"
    "Log"
    "Math"
    "MotionHandler"
    "ShakeShapeHandler"
    "Statistics"
    "Tags"
    "Transform"
    "TrimHandler"
  ];

  installPhase = installAegisubScript {
    inherit modules;
    modulePath = "src/";
    macroPath = "";
  } + ''
    install -D Aegisub-Motion.moon \
        $AegisubMotion/share/aegisub/automation/include/Aegisub-Motion.moon
    ln -s $AegisubMotion/share/aegisub/automation/include/Aegisub-Motion.moon \
        $out/share/aegisub/automation/include/
  '';
}
