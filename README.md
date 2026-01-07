# nix-dotfiles

my little repo for toying with NixOS and the Nix language

## a little explanation

this repo has a basic structure for multiple hosts with separate configurations running under the same NixOS config. look under the `hosts/` dir for a better idea of this. to build for a specific hostname, create the `.hostname` file and write out the desired hostname into it (ie. `echo "orchid" > .hostname`), then run `./build.sh`. if you just want to see if your changes work, you can also do `./build.sh --dry`, which doesn't require root.

## a few cool things

- file-based configuration: want a new hostname? create a new directory under `hosts/`, and under that, add a `host.nix` with the arch and hostname. you'll also want to create a `users/` dir, which is another file-based configuration--create another dir (lol) inside the `users/` dir with the name being the desired username, and include a `home.nix` and `user.nix`. the `home.nix` is the user's home-manager config, and the `user.nix` specifies how the user will be created.
- that's literally it
