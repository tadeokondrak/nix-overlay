{ stdenv, requireFile, autoPatchelfHook, rpm, cpio,
  gcc-unwrapped, libGL, libGLU, zlib, xorg, fontconfig, glib, freetype,
  readline5, ncurses5, sqlite, bzip2, openssl, libpng12, libtiff, gdbm, db4 }:

# If you have a licence, you can add it to your NixOS configuration like so:
# environment.etc."opt/isl/licences/mocha.lic".source = ./<your file here>.lic;

stdenv.mkDerivation rec {
  name = "mochapro";
  version = "5.6.0-1601.gcc41335b663b";

  src = requireFile {
    url = meta.downloadPage;
    name = "mochapro-${version}.x86_64.rpm";
    sha256 = "0npkrglly2nh98kqps20yhawh0ya40sfpvhzcvcxrcc7alqcy30g";
  };

  nativeBuildInputs = [
    autoPatchelfHook
  ];

  buildInputs = [
    gcc-unwrapped.lib # libstdc++.so.6
    libGL
    libGLU
    zlib
    fontconfig
    freetype
    readline5
    ncurses5
    sqlite
    bzip2
    openssl
    glib
    libpng12
  ] ++ (with xorg; [
    libXmu
    libXi
    libXrender
  ]);

  unpackPhase = ''
    ${rpm}/bin/rpm2cpio "$src" | ${cpio}/bin/cpio -id
    cp ${libtiff.out}/lib/libtiff.so opt/isl/mochaproV5/lib/libtiff.so.3
    cp ${gdbm.out}/lib/libgdbm.so opt/isl/mochaproV5/python/libgdbm.so.2
    cp ${db4.out}/lib/libdb.so opt/isl/mochaproV5/python/lib/libdb-4.3.so
  '';

  installPhase = ''
    mkdir $out
    mv opt $out
    substituteInPlace $out/opt/isl/mochaproV5/mochapro.desktop --replace "/usr/bin/mochapro" "mochapro" --replace "/opt/isl/mochaproV5/resources/mochaproIcon.ico" "mochaproIcon.ico"
    install -D $out/opt/isl/mochaproV5/mochapro.desktop $out/share/applications/mochapro.desktop
    install -D $out/opt/isl/mochaproV5/resources/Icon.ico $out/share/pixmaps/mochaproIcon.ico
    ln -s opt/isl/mochaproV5/bin $out/bin
  '';

  meta = with stdenv.lib; {
    description = "Motion tracking software";
    homepage = https://borisfx.com/products/mocha-pro/;
    downloadPage = https://borisfx.com/legacy-downloads/mocha-pro-5-6-0-standalone-application-linux/;
    license = licenses.unfree;
    maintainers = with maintainers; [ tadeokondrak ];
    platforms = [ "x86_64-linux" ];
  };
}
