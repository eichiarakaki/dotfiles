{ pkgs, ... }:

{
  programs.bash = {
    enable = true;

    shellAliases = {
      ".."  = "cd ..";
      "..." = "cd ../..";

      ll = "ls -lah";
      la = "ls -A";

      gs = "git status";
      ga = "git add";
      gc = "git commit";
      gp = "git push";
      gl = "git log --oneline --graph";

      update = "sudo nixos-rebuild switch --flake ~/nixcfg/nixos#quant";
      hm     = "home-manager switch --flake ~/nixcfg#ares@quant";

      grep = "grep --color=auto";
      df   = "df -h";
      du   = "du -sh";
    };
    bashrcExtra = ''
      set_prompt() {
        local reset='\[\e[0m\]'

        # blue = 728797
        local blue='\[\e[38;2;114;135;151m\]'

        # yellow = d9b27c
        local yellow='\[\e[38;2;217;178;124m\]'

        local nix_prefix=""

        if [[ -n "$IN_NIX_SHELL" ]]; then
          nix_prefix="''${blue}(nix)''${reset} "
        fi

        PS1="''${nix_prefix}''${blue}\W''${reset} ''${yellow}|''${reset} "
      }

      PROMPT_COMMAND=set_prompt
    '';
  };
}
