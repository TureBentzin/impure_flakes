{
  stdenv,
  lib,
  runtimeShell,
}:

let
  # Bring fileset functions into scope.
  # See https://nixos.org/manual/nixpkgs/stable/index.html#sec-functions-library-fileset
  inherit (lib.fileset) toSource unions;

  target =
    let
      env = builtins.getEnv "TARGET";
    in
    if env == "" then
      throw "Environment variable 'TARGET' needs to be defined. Are you using --impure?"
    else
      env;

in
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
    substitute impureTest.sh impureTest --replace-fail '@shell@' ${runtimeShell} --replace-warn '@target@' ${target}
    cat impureTest
    chmod a+x impureTest
  '';
  installPhase = ''
    install -D impureTest $out/bin/impureTest
  '';
  inherit target;
})
