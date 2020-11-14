# Wallpaper generator

Generate random wallpapers from mathematical functions using a color palette (like
`~/.Xresources`).

Add your own generators in `wp-gen.lua`.


#### Harmonograph

<img src="./examples/harmonograph/1.png" width="30%"></img> 
<img src="./examples/harmonograph/2.png" width="30%"></img> 
<img src="./examples/harmonograph/3.png" width="30%"></img> 
<img src="./examples/harmonograph/4.png" width="30%"></img> 
<img src="./examples/harmonograph/5.png" width="30%"></img> 

#### Lines

<img src="./examples/lines/1.png" width="30%"></img> 
<img src="./examples/lines/2.png" width="30%"></img> 

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
