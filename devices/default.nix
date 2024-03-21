{ inputs, ... }:

let inherit (inputs)
  darwin
  home-manager
  nixpkgs;
in
{
  flake = {
    darwinConfigurations = {
      "midnight-air" = import ./personal-macbook.nix { inherit darwin home-manager; };
      "Adams-Work-MBP" = import ./work-macbook.nix { inherit darwin home-manager; };
    };
  };
}
