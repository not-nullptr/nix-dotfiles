{ modules, ... }:

{
  imports = [
    modules.global.base           # obv
    modules.global.drivers.nvidia # main pc has an RTX 4090
  ];
}
