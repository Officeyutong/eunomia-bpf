{ 
  system ? builtins.currentSystem,
  pkgs ? import <nixpkgs> { system = system; },
  version ? "5.0.6"
}:

let
in pkgs.rustPlatform.buildRustPackage {
  pname = "myproject";
  version = "1.0.0";

  src = ./ecli;
cargoLock= { lockFile= ./ecli/Cargo.lock; };
   cargoHash = pkgs.lib.fakeHash;

  meta = with pkgs.lib; {
    description = "A fast line-oriented regex search tool, similar to ag and ack";
    homepage = "https://github.com/BurntSushi/ripgrep";
    license = licenses.unlicense;
    maintainers = [ maintainers.tailhook ];
  };
}
