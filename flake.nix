{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

    flake-parts = {
      url = "github:hercules-ci/flake-parts";
      inputs.nixpkgs-lib.follows = "nixpkgs";
    };
  };

  outputs =
    { flake-parts, ... }@inputs:
    flake-parts.lib.mkFlake { inherit inputs; } {
      systems = [ "x86_64-linux" ];

      perSystem =
        { pkgs, ... }:
        {
          formatter = pkgs.nixfmt-tree;

          devShells.default = pkgs.mkShell {
            packages = builtins.attrValues {
              inherit (pkgs)
                gcc
                ;
            };
          }; 

          packages = {
            dwm = pkgs.stdenv.mkDerivation {
              pname = "dwm";
              version = "6.6";
              src = ./dwm/src-patched;

              buildInputs = with pkgs.xorg; [
                libX11
                libXft
                libXinerama
                libxcb
              ];

              buildPhase = ''
                make
              '';

              installPhase = ''
                mkdir -p $out/bin
                mv dwm $out/bin
              '';

              meta = {
                description = "Dynamic window manager for X";
                license = pkgs.lib.licenses.mit;
              };
            };
            slock = pkgs.stdenv.mkDerivation {
              pname = "slock";
              version = "1.6";
              src = ./slock/src-patched;

              buildInputs = with pkgs.xorg; [
                libX11
                libXext
                libXrandr
                pkgs.libxcrypt
              ];

              buildPhase = ''
                make
              '';

              installPhase = ''
                mkdir -p $out/bin
                mv slock $out/bin
              '';

              meta = {
                description = "Simple X display locker";
                license = pkgs.lib.licenses.mit;
              };
            };
          };
        };
    };
}
