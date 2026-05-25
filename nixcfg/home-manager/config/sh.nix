{ pkgs, ... }:

{
  programs.bash = {
    enable = true;

    shellAliases = {
      # Navigation
      ".."  = "cd ..";
      "..." = "cd ../..";
      ll    = "ls -lah";
      la    = "ls -A";

      # Git
      gs  = "git status";
      ga  = "git add";
      gc  = "git commit";
      gp  = "git push";
      gl  = "git log --oneline --graph";

      # System
      update = "sudo nixos-rebuild switch --flake ~/nixcfg/nixos#quant";
      hm     = "home-manager switch --flake ~/nixcfg#ares@quant";

      # Utils
      grep = "grep --color=auto";
      df   = "df -h";
      du   = "du -sh";
    };
  };
}
