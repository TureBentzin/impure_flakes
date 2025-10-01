{
  description = "Impure demo";

  inputs = {
    flake-parts.url = "github:hercules-ci/flake-parts";
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs =
    inputs@{ flake-parts, ... }:
    flake-parts.lib.mkFlake { inherit inputs; } {
      systems = [
        "x86_64-linux"
        "aarch64-linux"
        "aarch64-darwin"
        "x86_64-darwin"
      ];
      perSystem =
        { config, pkgs, ... }:
        {
          packages.default = config.packages.impureTest;

          packages.impureTest = pkgs.callPackage ./impureTest/package.nix { };

          checks.impureTest = pkgs.callPackage ./impureTest/test.nix {
            impureTest = config.packages.impureTest;
          };
        };
    };
}
