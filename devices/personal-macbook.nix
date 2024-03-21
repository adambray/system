{ darwin, home-manager }:

darwin.lib.darwinSystem {
  system = "aarch64-darwin";
  modules = [
    home-manager.darwinModules.home-manager
    ../modules/nix-darwin
    {
      homebrew.casks = [
        "tandem"
        "dbvisualizer"
      ];
      home-manager.users.adambray = {
        programs.zsh = {
          profileExtra = ''eval "$(/opt/homebrew/bin/brew shellenv)"'';
        };
      };
    }
  ];
}
