{ pkgs, ... }:
{
  programs.bash = {
    enable = true;
    shellAliases = {
      ".."  = "cd ..";
      "..." = "cd ../..";
      ll    = "ls -lah";
      la    = "ls -A";
      gs    = "git status";
      ga    = "git add";
      gc    = "git commit";
      gp    = "git push";
      gl    = "git log --oneline --graph";
      update = "sudo nixos-rebuild switch --flake ~/nixcfg/nixos#quant";
      hm     = "home-manager switch --flake ~/nixcfg#ares@quant";
      grep  = "grep --color=auto";
      df    = "df -h";
      du    = "du -sh";
    };
    bashrcExtra = ''
      set_prompt() {
        local reset='\[\e[0m\]'
        local dim='\[\e[90m\]'
        local white='\[\e[37m\]'
        local dull_red='\[\e[38;5;131m\]'

        local dir="$white\W"
        local sep="$dim :"
        local symbol="$dim > "

        local git_branch=""
        if git rev-parse --is-inside-work-tree &>/dev/null 2>&1; then
          local branch
          branch=$(git symbolic-ref --short HEAD 2>/dev/null || git rev-parse --short HEAD 2>/dev/null)
          git_branch="$dim[$white$branch$dim]"
        fi

        local nix_tag=""
        if [[ -n "$IN_NIX_SHELL" ]]; then
          nix_tag="$dull_red[nix]$dim "
        fi

        PS1="$nix_tag$dir$git_branch$symbol$reset"
      }
      PROMPT_COMMAND=set_prompt
    '';
  };
}
