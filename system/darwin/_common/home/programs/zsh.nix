{ pkgs, ... }:

{
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    history.ignoreDups = true;
    history.ignoreSpace = true;

    plugins = [
      {
        name = "zsh-abbr";
        src = "${pkgs.zsh-abbr}/share/zsh/zsh-abbr";
      }
    ];

    initContent = ''
      # --- 1Password SSH Agent ---
      export SSH_AUTH_SOCK="$HOME/Library/Group Containers/2BUA8C4S2C.com.1password/t/agent.sock"

      # --- Abbreviations ---
      abbr -S -q g=git
      abbr -S -q ga="git add"
      abbr -S -q gc="git commit"
      abbr -S -q gp="git push"
      abbr -S -q gst="git status"
      abbr -S -q gd="git diff"
      abbr -S -q lg=lazygit
      abbr -S -q v=nvim
      abbr -S -q -f cat=bat
      abbr -S -q -f cd=z
      abbr -S -q ..="z .."
      abbr -S -q ...="z ../.."
      abbr -S -q -f ls="eza --icons --group-directories-first"
      abbr -S -q ll="eza -la --icons --git --group-directories-first"
      abbr -S -q lt="eza -la --icons --git --group-directories-first -T -L 2"

      # --- Functions ---
      function vf() { nvim "$(fzf)" }
      function cf() { bat "$(fzf)" }

      # --- Welcome Message ---
      fastfetch
    '';
  };
}
