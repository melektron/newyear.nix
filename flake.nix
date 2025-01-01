{
  description = "Greetings and happy 2025!";
  inputs.flake-utils.url = "github:numtide/flake-utils";
  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs { inherit system; };
        my-name = "newyear";
        my-buildInputs = with pkgs; [ figlet lolcat ];
        my-script = pkgs.writeShellScriptBin my-name ''
        figlet Happy new year 2025! At least Something more than GOARNIX. | lolcat
        '';
      in rec {
        defaultPackage = packages.newyear;
        packages.newyear = pkgs.symlinkJoin {
          name = my-name;
          paths = [ my-script ] ++ my-buildInputs;
          buildInputs = [ pkgs.makeWrapper ];
          postBuild = "wrapProgram $out/bin/${my-name} --prefix PATH : $out/bin";
        };
      }
    );
}
