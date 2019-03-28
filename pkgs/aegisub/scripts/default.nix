{ stdenv, pkgs }:

let
  callPackage = pkgs.newScope self;
  self = {
    installAegisubScript = callPackage ./install-aegisub-script.nix { };

    aegisub-motion = callPackage ./aegisub-motion { };
    assfoundation = callPackage ./assfoundation { };
    coffeeflux = callPackage ./coffeeflux { };
    dependencycontrol = callPackage ./dependencycontrol { };
    ffi-experiments = callPackage ./ffi-experiments { };
    functional = callPackage ./functional { };
    line0 = callPackage ./line0 { };
    luajson = callPackage ./luajson { };
    subinspector = callPackage ./subinspector { };
    torque = callPackage ./torque { };
    lyger = callPackage ./lyger { };
    unanimated = callPackage ./unanimated { };
    yutils = callPackage ./yutils { };
  };
in
  self
