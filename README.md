## Development

If you have [nix]() installed, use the provided `nix-shell` to run and build the
script.

```bash
user@host: nix-shell
[nix-shell:~/path]
```

Run `main.lua`, all dependencies should be there
```
[nix-shell:~/path] lua main.lua
```

TODO ALIASES
feh -F --auto-reload
echo main.lua | entr sh -c 'lua main.lua'
