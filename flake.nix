{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.05";
  };
  outputs = { nixpkgs, ... }:
    let
      pkgs = import nixpkgs { system = "x86_64-linux"; };
    in
    {
      packages."x86_64-linux".default = pkgs.stdenv.mkDerivation {
        name = "hello-pionix";
        src = ./src;
        # only build tools. 
        # use `buildInputs` for runtime libs for cross compile 
        nativeBuildInputs = [ pkgs.rustc ]; 
        buildPhase = ''
          rustc main.rs
        '';
        installPhase = ''
          mkdir -p $out/bin
          cp main $out/bin/hello-pionix
        '';
      };
    };
}
