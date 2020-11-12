with import <nixpkgs> {};
with luaPackages;

let
  libs = [lua lgi];
in
stdenv.mkDerivation rec {
  name = "lua-env";
  buildInputs = libs;

  shellHook = ''
    export LUA_CPATH="${lib.concatStringsSep ";" (map getLuaCPath libs)}"
    export LUA_PATH="${lib.concatStringsSep ";" (map getLuaPath libs)};$LUA_PATH;$(pwd)/?.lua"
  '';
}
