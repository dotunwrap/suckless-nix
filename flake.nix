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

          packages.default = pkgs.stdenv.mkDerivation {
            pname = "dwm";
            version = "6.6";
            src = ./src-patched;

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
              description = "Dynamic window manager for X - Gabby's Version";
              license = pkgs.lib.licenses.mit;
            };
          };
        };
    };
}
