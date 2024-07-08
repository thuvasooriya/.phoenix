# phoenix

<p align="center">
	<a href="https://github.com/ryan4yin/nix-config/stargazers">
		<img alt="stargazers" src="https://img.shields.io/github/stars/thuvasooriya/.phoenix?style=for-the-badge&logo=starship&color=C9CBFF&logoColor=D9E0EE&labelColor=302D41"></a>
    <a href="https://nixos.org/">
        <img src="https://img.shields.io/badge/NixOS-24.05-informational.svg?style=for-the-badge&logo=nixos&color=F2CDCD&logoColor=D9E0EE&labelColor=302D41"></a>
    <a href="https://github.com/ryan4yin/nixos-and-flakes-book">
        <img src="https://img.shields.io/static/v1?label=Nix Flakes&message=learning&style=for-the-badge&logo=nixos&color=DDB6F2&logoColor=D9E0EE&labelColor=302D41"></a>
  </a>
</p>

**nix** config to be reborn again and again anywhere and everywhere.

apart from the sexy name, this config is nowhere near useable. i'm currently testing it on my macbook with apple silicon and some of my cute little linux machines which are also aarch64. so i don't think this is the phoe**nix** that i want it to be yet, but i mean... when is a child ever what you want to be. (cringe intended)

directory strcture and helper functions are copied from ryan4yin's config

## setup note

```bash
# if you are deploying for the first time,
# 1. install nix & homebrew manually.
# 2. prepare the deployment environment with essential packages available
nix-shell -p just nushell
# 3. comment home-manager's code in lib/macos_system.nix to speed up the first deplyment.
# deploy madhu's configuration(apple silicon)
just ma
# or
# deploy with details
just ma debug
```

> [what y'all will need when nix drives you to drink.](https://www.youtube.com/watch?v=Eni9PPPPBpg)
> (copy from ryan4yin's nix-config repo, when i pulled an all nighter to finish the damn restructuring, this thing really held me togeather)

## current goals

- [ ] error free mac config: madhu
- [ ] setup nixos vm config for orbstack and parallels(desktop): shoko
- [ ] setup orangepi02w sbc config: gojo
- [ ] setup raspberry pi 4b config: yuji
- [ ] siphon the whole ghostty terminal setup on macOS to be reproducible

## looking forward

- [ ] error handling
- [ ] stability pinning
- [ ] encryption and securities automation
- [ ] system-manager for generic linux

## done

- [x] basic fish and starship setup
- [x] porting my starship and fish goodies to nix
- [x] transferred all homebrew casks
- [x] initial zig setup for zvm support
- [x] initial nvim config with partial determinism

### references

- https://github.com/malob/nixpkgs/
- https://github.com/PaulGrandperrin/nix-systems
- https://github.com/ryan4yin/nix-config

### sacrifices

whole damn days and a whole fucking load of sanity
