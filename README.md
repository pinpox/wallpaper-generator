## nix-shell

```bash
nix-shell -p pkgs.lua -p pkgs.luaPackages.lgi -p pkgs.entr
echo main.lua | entr sh -c 'lua main.lua'
feh -F --auto-reload cairodemo-harmonograph.png
```
