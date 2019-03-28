{ stdenv, fetchFromGitHub, installAegisubScript }:

with stdenv.lib;

stdenv.mkDerivation rec {
  pname = "coffeeflux-scripts";
  version = "e1e01e6a4830924292e1d4bf15444c276f4c1791";

  src = fetchFromGitHub {
    owner = "TypesettingTools";
    repo = "CoffeeFlux-Aegisub-Scripts";
    rev = version;
    sha256 = "0yqm7wjcbn1gfvafxxzqx57cp8ma645izbwd788cwl1dgvfzib7r";
  };

  outputs = [
    "out"
  ] ++ macros
    ++ modules;

  macros = [
    "DialogSwapper"
    "JumpScroll"
    "LineSeparator"
    "ScaleRotTags"
    "Selegator"
    "TestTitleCase"
    "TitleCase"
  ];

  modules = [
    "ScrollHandler"
    "TPPPBase"
  ];

  installPhase = installAegisubScript {
    inherit modules macros;
    prefix = "Flux.";
  };
}
