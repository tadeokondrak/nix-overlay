{ stdenv, fetchFromGitHub, installAegisubScript }:

stdenv.mkDerivation rec {
  pname = "dependencycontrol";
  version = "0.6.4";

  src = fetchFromGitHub {
    owner = "TypesettingTools";
    repo = "DependencyControl";
    rev = "v${version}-alpha";
    sha256 = "1yjxw4kaknwkwapfivl67861zm3nblr67g9v44hbkk5qs17dx6kp";
  };

  outputs = [
    "out"
  ] ++ macros
    ++ modules;

  macros = [
    "Toolbox"
  ];

  modules = [
    "DependencyControl"
  ];

  installPhase = installAegisubScript {
    inherit modules macros;
    macroPrefix = "l0.DependencyControl.";
  };
}
