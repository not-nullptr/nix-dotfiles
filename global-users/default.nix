{
  lib,
  ...
}:

let
  cwd = builtins.readDir ./.;
  users = lib.filter (name: cwd.${name} == "directory") (lib.attrNames cwd);
in
lib.listToAttrs (
  map (username: {
    name = username;
    value =
      let
        user = import ./${username}/user.nix;
        home = import ./${username}/home.nix;
      in
      {
        inherit user home;
      };
  }) users
)
