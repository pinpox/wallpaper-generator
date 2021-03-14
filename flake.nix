{
  description = "Generate wallpaper images from mathematical functions";

  inputs.flake-utils.url = "github:numtide/flake-utils";

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
        lua = pkgs.lua.withPackages (ps: with ps; [ lgi luafilesystem ]);
      in rec {
        packages = flake-utils.lib.flattenTree {
          wp-gen = pkgs.stdenv.mkDerivation {
            name = "wallpaper-generator";
            src = self;
            buildInputs =
              [ pkgs.luaPackages.luafilesystem pkgs.luaPackages.lgi pkgs.lua ];
            installPhase = "mkdir -p $out; mv * $out";
          };
        };
        defaultPackage = packages.wp-gen;

        apps.wp-gen = flake-utils.lib.mkApp {
          drv = pkgs.writeScriptBin "wallpaper-generator" ''
            export LUA_PATH="$LUA_PATH;$(pwd)/?.lua"
            ${lua}/bin/lua main.lua wp-gen.lua
          '';
        };
        defaultApp = apps.wp-gen;
      });
}
