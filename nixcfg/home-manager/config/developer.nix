{ pkgs, ... }:

{
  programs.git = {
    enable = true;
    settings.user.name   = "Eichi Arakaki";
    settings.user.email  = "justanunusualperson@gmail.com";
    settings = {
      init.defaultBranch = "main";
      pull.rebase        = true;
    };
  };

  home.packages = with pkgs; [
    vscode
    zellij
    #tmux
    jetbrains.goland
    jetbrains.rust-rover
    lazygit
    jq
  ];
}
