{ config, ... }:

{
  home = {
    file.".1password/agent.sock" = {
      source = config.lib.file.mkOutOfStoreSymlink
        "${config.home.homeDirectory}/Library/Group Containers/2BUA8C4S2C.com.1password/t/agent.sock";
    };

    sessionVariables = {
      SSH_AUTH_SOCK = "~/.1password/agent.sock";
    };
  };

  programs.git = {
    signing = {
      key = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIDYPlWUM3LaYEP8hKUWCaixu6X+yNq96v1YIC9Diu+M2";
      signByDefault = true;
    };

    extraConfig = {
      gpg = { format = "ssh"; };
      "gpg \"ssh\"" = { program = "/Applications/1Password.app/Contents/MacOS/op-ssh-sign"; };
    };
  };

  programs.ssh = {
    enable = true;
    matchBlocks."github.com" = {
      extraOptions = {
        identityAgent = "~/.1password/agent.sock";
      };
    };
  };
}
