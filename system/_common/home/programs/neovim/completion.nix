{ lib, ... }:

let
  inherit (import ./lib.nix { inherit lib; }) dir;
in
{
  plugins = {
    # --- Completion ---
    blink-cmp = {
      enable = true;
      settings = {
        keymap = {
          preset = "none";

          "<S-Space>" = [
            "show"
            "show_documentation"
            "hide_documentation"
          ];
          "<Tab>" = [
            "accept"
            "fallback"
          ];
          "<C-${dir.down}>" = [
            "select_next"
            "fallback"
          ];
          "<C-${dir.up}>" = [
            "select_prev"
            "fallback"
          ];
          # Move placeholder when expanding snippet
          "<C-b>" = [
            "snippet_backward"
            "fallback"
          ];
          "<C-f>" = [
            "snippet_forward"
            "fallback"
          ];
        };
        appearance = {
          use_nvim_cmp_as_default = true;
          nerd_font_variant = "mono";
        };
        sources.default = [
          "lsp"
          "path"
          "snippets"
          "buffer"
        ];
      };
    };

    # AI completion via local Ollama (services.ollama in ollama.nix)
    minuet = {
      enable = true;
      settings = {
        provider = "openai_fim_compatible";
        n_completions = 1;
        context_window = 1024;
        request_timeout = 3;
        provider_options.openai_fim_compatible = {
          name = "Ollama";
          api_key = "TERM"; # Ollama needs no key, but minuet requires an existing env var name
          end_point = "http://localhost:11434/v1/completions";
          model = "qwen2.5-coder:7b";
          optional = {
            max_tokens = 56;
            top_p = 0.9;
          };
        };
        virtualtext = {
          auto_trigger_ft = [ "*" ];
          keymap = {
            accept = "<C-CR>";
            accept_line = "<C-l>";
            next = "<C-]>";
            prev = "<C-\\>"; # <C-[> is indistinguishable from <Esc> in terminals
            dismiss = "<C-e>";
          };
        };
      };
    };
  };
}
