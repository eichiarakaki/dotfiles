{ config, pkgs, lib, ... }:

{
  programs.emacs = {
    enable = true;
    package = pkgs.emacs;

    extraPackages = epkgs: with epkgs; [
      dash
      dash-functional

      gruber-darker-theme

      smex
      helm

      paredit
      multiple-cursors
      move-text
      yasnippet

      org-cliplink
      magit
      company

      haskell-mode
      tuareg
      scala-mode
      d-mode
      yaml-mode
      glsl-mode
      lua-mode
      less-css-mode
      graphviz-dot-mode
      clojure-mode
      cmake-mode
      rust-mode
      csharp-mode
      nim-mode
      jinja2-mode
      markdown-mode
      purescript-mode
      nix-mode
      dockerfile-mode
      toml-mode
      nginx-mode
      kotlin-mode
      go-mode
      php-mode
      racket-mode
      qml-mode
      typescript-mode
      tide
      flycheck
      elpy
      ag
      rfc-mode
      sml-mode
      uxntal-mode
      powershell
      rainbow-mode
      proof-general
    ];

    extraConfig = ''
      ;; custom.el
      (setq custom-file
            (expand-file-name "emacs-custom.el" user-emacs-directory))

      ;; packages
      (require 'dash)
      (require 'dash-functional)

      ;; startup
      (setq inhibit-startup-screen t)
      (setq inhibit-startup-message t)
      (setq inhibit-splash-screen t)
      (setq initial-scratch-message nil)

      ;; Disable startup screen completely
      (setq inhibit-startup-echo-area-message user-login-name)
      (setq initial-buffer-choice t)

      ;; appearance
      (tool-bar-mode -1)
      (menu-bar-mode -1)
      (scroll-bar-mode -1)

      (column-number-mode 1)
      (show-paren-mode 1)
      (global-display-line-numbers-mode 1)

      (set-face-attribute 'default nil
                          :font "Iosevka-14")

      (load-theme 'gruber-darker t)

      ;; general
      (setq make-backup-files nil)
      (setq auto-save-default nil)
      (setq ring-bell-function 'ignore)

      (setq-default
        tab-width 4
        indent-tabs-mode nil)

      ;; ido
      (ido-mode 1)
      (ido-everywhere 1)

      ;; smex
      (smex-initialize)

      (global-set-key (kbd "M-x") #'smex)

      ;; org
      (require 'org)
      (require 'org-cliplink)

      (setq org-agenda-files
            '("~/Documents/Agenda/"))

      (global-set-key
        (kbd "C-x a")
        #'org-agenda)

      ;; whitespace
      ;; trim on save only
      ;; no $ markers
      ;; no visual highlight
      (defun rc/set-up-whitespace-handling ()
        (add-hook 'before-save-hook
                  #'delete-trailing-whitespace
                  nil
                  t))

      (dolist (hook
               '(tuareg-mode-hook
                 c-mode-hook
                 c++-mode-hook
                 rust-mode-hook
                 go-mode-hook
                 lua-mode-hook
                 scala-mode-hook
                 markdown-mode-hook
                 haskell-mode-hook
                 python-mode-hook
                 yaml-mode-hook
                 nix-mode-hook))
        (add-hook hook
                  #'rc/set-up-whitespace-handling))

      ;; c
      (setq-default
        c-basic-offset 4
        c-default-style
        '((java-mode . "java")
          (awk-mode . "awk")
          (other . "bsd")))

      ;; paredit
      (defun rc/turn-on-paredit ()
        (paredit-mode 1))

      (add-hook 'emacs-lisp-mode-hook #'rc/turn-on-paredit)
      (add-hook 'clojure-mode-hook #'rc/turn-on-paredit)
      (add-hook 'lisp-mode-hook #'rc/turn-on-paredit)
      (add-hook 'racket-mode-hook #'rc/turn-on-paredit)

      ;; haskell
      (setq haskell-process-type 'cabal-new-repl)

      (add-hook
        'haskell-mode-hook
        #'interactive-haskell-mode)

      ;; company
      (require 'company)
      (global-company-mode)

      ;; magit
      (setq magit-auto-revert-mode nil)

      (global-set-key
        (kbd "C-c m s")
        #'magit-status)

      ;; multiple cursors
      (global-set-key
        (kbd "C-S-c C-S-c")
        #'mc/edit-lines)

      (global-set-key
        (kbd "C->")
        #'mc/mark-next-like-this)

      (global-set-key
        (kbd "C-<")
        #'mc/mark-previous-like-this)

      ;; move-text
      (global-set-key
        (kbd "M-p")
        #'move-text-up)

      (global-set-key
        (kbd "M-n")
        #'move-text-down)

      ;; yas
      (require 'yasnippet)

      (setq yas-snippet-dirs
            '("~/.emacs.snippets"))

      (yas-global-mode 1)

      ;; typescript
      (add-to-list
        'auto-mode-alist
        '("\\.mts\\'" . typescript-mode))

      (defun rc/setup-tide ()
        (tide-setup)
        (flycheck-mode 1))

      (add-hook
        'typescript-mode-hook
        #'rc/setup-tide)

      ;; dired
      (require 'dired-x)

      (setq dired-listing-switches "-alh")
      (setq-default dired-dwim-target t)

      ;; local modes
      (add-to-list 'load-path
                   (expand-file-name "~/.emacs.local"))

      (require 'basm-mode nil t)
      (require 'fasm-mode nil t)
      (require 'porth-mode nil t)
      (require 'noq-mode nil t)
      (require 'jai-mode nil t)
      (require 'simpc-mode nil t)
      (require 'umka-mode nil t)
      (require 'c3-mode nil t)

      ;; powershell
      (add-to-list 'auto-mode-alist
                   '("\\.ps1\\'" . powershell-mode))

      ;; custom
      (when (file-exists-p custom-file)
        (load custom-file))
    '';
  };

  home.file.".config/emacs/emacs-custom.el".text = ''
    (custom-set-variables
      '(display-line-numbers-type 'relative)
      '(warning-minimum-level :error))

    (custom-set-faces)
  '';
}