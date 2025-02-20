{ pkgs, ... }:
let
  pname = "genki-docs";
  version = "0.1.0";
  src = ./..;
in
pkgs.stdenv.mkDerivation {
  inherit pname version src;

  nativeBuildInputs = [
    pkgs.nodejs
    pkgs.pnpm.configHook
    pkgs.typescript
    pkgs.vips
    pkgs.pkg-config
  ];
  buildPhase = ''
    pnpm build
  '';

  installPhase = ''
    runHook preInstall
    cp -pr --reflink=auto dist $out/
    runHook postInstall
  '';

  pnpmDeps = pkgs.pnpm.fetchDeps {
    inherit pname version src;
    hash = "sha256-2OXwnhc6rN3j7vWB5UBardWt38u+X6wfH+9wOfseIXY=";
  };
}
