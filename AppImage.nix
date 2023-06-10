{ 
  system ? builtins.currentSystem,
  pkgs ? import <nixpkgs> { system = system; },
  version ? "5.0.6"
}:

let
in pkgs.stdenvNoCC.mkDerivation {
  name = "ecli-rs-${version}";
  system = system;
  src = ./ecli/target/release/ecli-rs;
  # https://github.com/oxalica/rust-overlay/commit/c949d341f2b507857d589c48d1bd719896a2a224
  depsHostHost = pkgs.lib.optional (!pkgs.hostPlatform.isDarwin) pkgs.gccForLibs.lib;
  nativeBuildInputs = [
    pkgs.autoPatchelfHook
  ];
  buildInputs = [
    pkgs.elfutils
  ];
  unpackPhase = "true";
  installPhase = ''
    mkdir -p $out/bin
    cp $src $out/bin/ecli-rs
    chmod +x $out/bin/ecli-rs
  '';

  meta = {
    description = "test";
    homepage = https://www.mongodb.com/;
    maintainers = [ "undefined <i@undefined.moe>" ];
    platforms = [ system ];
  };
}
