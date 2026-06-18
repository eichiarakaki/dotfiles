{ pkgs, lib, ... }:

let
  # Change only this line to switch themes.
  theme = ./kak/themes/base16-default-dark.kak;
in
{
  programs.kakoune = {
    enable = true;

    config = {
      numberLines = {
        enable = true;
        relative = true;
      };

      showMatching = true;

      scrollOff = {
        columns = 5;
        lines = 3;
      };

      tabStop = 4;
      indentWidth = 4;
    };

    extraConfig = ''
      source "${theme}"

      # Copy every normal yank to the system clipboard.
      #
      # Wayland: wl-copy
      # X11 fallback: xclip
      #
      # Important:
      # - Do not remap `y`; keep Kakoune's native yank behavior.
      # - xclip is backgrounded because otherwise it can block Kakoune.
      define-command -hidden copy-yank-to-system-clipboard %{
        nop %sh{
          [ -n "''${kak_main_reg_dquote:-}" ] || exit 0

          if [ -n "''${WAYLAND_DISPLAY:-}" ] && command -v wl-copy >/dev/null 2>&1; then
            printf %s "$kak_main_reg_dquote" | wl-copy

          elif [ -n "''${DISPLAY:-}" ] && command -v xclip >/dev/null 2>&1; then
            printf %s "$kak_main_reg_dquote" | xclip -selection clipboard -in >/dev/null 2>&1 &

          else
            printf 'kak: no clipboard provider found: install wl-clipboard or xclip\n' >&2
            exit 1
          fi
        }
      }

      hook global NormalKey y %{
        copy-yank-to-system-clipboard
      }

      # Optional explicit Wayland clipboard shortcuts.
      # Alt-y: copy current selections directly to system clipboard.
      # Alt-p: paste system clipboard after cursor.
      map global normal <a-y> '<a-|>wl-copy<ret>'
      map global normal <a-p> '<a-!>wl-paste -n<ret>'
    '';
  };

  home.packages = with pkgs; [
    wl-clipboard
    xclip
  ];
}
