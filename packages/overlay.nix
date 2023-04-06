self: super:

{
  livebook = super.callPackage ./livebook.nix { };
  tmux-resurrect = super.callPackage ./tmux-resurrect.nix { };
  vscode-update-exts = super.callPackage ./vscode-update-exts { };
}
