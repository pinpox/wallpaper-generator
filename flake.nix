{
  description = "Generate wallpaper images from mathematical functions";

  inputs.flake-utils.url = "github:numtide/flake-utils";

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
        lua-with-pkgs =
          pkgs.lua.withPackages (ps: with ps; [ lgi luafilesystem ]);

        libs = [ pkgs.lua pkgs.luaPackages.lgi pkgs.luaPackages.luafilesystem ];
      in rec {
        packages = flake-utils.lib.flattenTree rec {

          wp-gen = pkgs.stdenv.mkDerivation rec {
            pname = "wallpaper-generator";
            version = "1.0";

            src = self;

            dontBuild = true;

            nativeBuildInputs = [ pkgs.makeWrapper ];

            buildInputs = [ lua-with-pkgs ];

            installPhase = ''
              runHook preInstall
              install -Dm755 main.lua $out/bin/wallpaper-generator
              install -Dm755 wp-gen.lua $out/bin/wp-gen.lua
              install -Dm755 -d generators $out/bin/generators

              wrapProgram $out/bin/wallpaper-generator \
                --set LUA_CPATH "${ pkgs.lib.concatStringsSep ";" (map pkgs.luaPackages.getLuaCPath libs) }" \
                --set LUA_PATH "${self}/?.lua"

              runHook postInstall
            '';

            meta = with pkgs.stdenv.lib; {
              homepage = "https://github.com/pinpox/wallpaper-generator";
              description = "Generate wallpaper images from mathematical functions";
              license = licenses.mit;
              maintainers = [ maintainers.pinpox ];
            };
          };

        };
        defaultPackage = packages.wp-gen;

        apps.wp-gen = packages.wp-gen;
        defaultApp = apps.wp-gen;
      });
}
