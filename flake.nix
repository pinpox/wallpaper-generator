{
  description = "Generate wallpaper images from mathematical functions";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
    flake-compat = {
      url = "github:edolstra/flake-compat";
      flake = false;
    };
  };

  outputs = { self, nixpkgs, flake-utils, ... }:

  {
    checks."x86_64-linux".example = self.packages."x86_64-linux".wp-gen;
  } //

    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
        lua-with-pkgs =
          pkgs.lua.withPackages (ps: with ps; [ lgi luafilesystem argparse ]);

        libs = [
          pkgs.lua
          pkgs.luaPackages.lgi
          pkgs.luaPackages.luafilesystem
          pkgs.luaPackages.argparse
        ];

      in rec {
        packages = flake-utils.lib.flattenTree rec {

          wp-gen = pkgs.stdenv.mkDerivation rec {
            pname = "wallpaper-generator";
            version = "1.0";

            src = self;

            dontBuild = true;

            nativeBuildInputs = [ pkgs.makeWrapper ];

            buildInputs = [
              lua-with-pkgs
              pkgs.gobject-introspection
              pkgs.cairo
            ];

            installPhase = ''
              runHook preInstall
              install -Dm755 main.lua $out/bin/wallpaper-generator
              install -Dm755 -d generators $out/bin/generators

              wrapProgram $out/bin/wallpaper-generator \
                --set LUA_CPATH "${
                  pkgs.lib.concatStringsSep ";"
                  (map pkgs.luaPackages.getLuaCPath libs)
                }" \
                --set LUA_PATH "${self}/?.lua"

              runHook postInstall
            '';

            meta = with pkgs.lib; {
              homepage = "https://github.com/pinpox/wallpaper-generator";
              description =
                "Generate wallpaper images from mathematical functions";
              license = licenses.mit;
              maintainers = [ maintainers.pinpox ];
            };
          };

        };
        defaultPackage = packages.wp-gen;
      });
}
