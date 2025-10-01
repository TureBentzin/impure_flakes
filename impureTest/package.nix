{ stdenv, lib, runtimeShell }:

let
  # Bring fileset functions into scope.
  # See https://nixos.org/manual/nixpkgs/stable/index.html#sec-functions-library-fileset
  inherit (lib.fileset) toSource unions;
in

# Example package in the style that `mkDerivation`-based packages in Nixpkgs are written.
stdenv.mkDerivation (finalAttrs: {
  name = "impureTest";
  src = toSource {
    root = ./.;
    fileset = unions [
      ./impureTest.sh
    ];
  };
  buildPhase = ''
    # Note that Nixpkgs has builder functions for simple packages
    # like this, but this template avoids it to make for a more
    # complete example.
    substitute impureTest.sh impureTest --replace '@shell@' ${runtimeShell}
    cat impureTest
    chmod a+x impureTest
  '';
  installPhase = ''
    install -D impureTest $out/bin/impureTest
  '';
})
