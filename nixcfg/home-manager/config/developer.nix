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
    zellij
    zed-editor-fhs

    #jetbrains.goland
    #jetbrains.rust-rover
    #lazygit
    #jq
  ];
}
