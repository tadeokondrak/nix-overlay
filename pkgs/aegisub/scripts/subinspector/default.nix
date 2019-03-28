{ stdenv, fetchFromGitHub, meson, ninja, pkg-config, libass, libiconvReal, bzip2, zlib }:

stdenv.mkDerivation rec {
  pname = "subinspector";
  version = "c1154a0e4c490d9dbaa8ca542b0fb7209c85fb5a";

  src = fetchFromGitHub {
    owner = "TypesettingTools";
    repo = "SubInspector";
    rev = version;
    sha256 = "00xk6p3b5a2xb78mpaz68pxynhlapm7s0i97ir7wa3fm4l2ndd09";
  };

  nativeBuildInputs = [ meson ninja pkg-config ];
  buildInputs = [ libass libiconvReal bzip2 zlib ];

  mesonFlags = [ "-Dzlib=enabled" ];

  installPhase = ''
    install -D ../examples/Aegisub/Inspector.moon $out/share/aegisub/automation/autoload/Inspector.moon
    install -D src/libSubInspector.so $out/share/aegisub/automation/include/SubInspector/Inspector/libSubInspector.so
  '';
}
