{ darwin, flake-utils, home-manager, nixpkgs }:

{
  darwinConfigurations = {
    "Adam-Personal-MBP" = import ./personal-macbook.nix { inherit darwin flake-utils home-manager; };
    "Adam-Work-MBP" = import ./work-macbook.nix { inherit darwin flake-utils home-manager; };
  };
}
