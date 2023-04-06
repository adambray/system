{
  homebrew.enable = true;
  homebrew.casks = [
    "1password-cli"
    "1password"
    "beekeeper-studio"
    "bettertouchtool"
    "discord"
    "disk-inventory-x"
    "docker"
    "firefox"
    "google-chrome"
    "google-cloud-sdk"
    "google-drive"
    "iterm2"
    "keepingyouawake"
    "keycastr"
    "nushell"
    "obsidian"
    "raycast"
    "rectangle"
    "slack"
    "starship"
    "warp"
    "zellij"
    "zoom"
];

  nix.settings.experimental-features = [
    "flakes"
    "nix-command"
    "repl-flake"
  ];

  nixpkgs.config.allowUnfree = true;

  programs.zsh.enable = true;

  security.pam.enableSudoTouchIdAuth = true;

  services.nix-daemon.enable = true;

  system.keyboard.enableKeyMapping = true;
  system.keyboard.remapCapsLockToControl = true;

  system.defaults.dock.autohide = true;

  system.stateVersion = 4;
}
