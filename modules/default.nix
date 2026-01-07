{ lib, ... }:

let
  mkModules =
    dir:
    let
      contents = builtins.readDir dir;

      processEntry =
        name: type:
        if type == "directory" then
          {
            name = name;
            value = mkModules (dir + "/${name}");
          }
        else if type == "regular" && lib.hasSuffix ".nix" name && name != "default. nix" then
          {
            name = lib.removeSuffix ".nix" name;
            value = dir + "/${name}";
          }
        else
          null;

      entries = lib.mapAttrsToList processEntry contents;
      validEntries = builtins.filter (x: x != null) entries;
    in
    builtins.listToAttrs validEntries;
in
{
  global = mkModules ./global;
  user = mkModules ./user;
}
