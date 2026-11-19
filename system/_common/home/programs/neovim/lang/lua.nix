{ ... }:

{
  plugins = {
    treesitter.settings.ensure_installed = [
      "lua"
      "luadoc"
    ];

    lazydev.enable = true;

    conform-nvim.settings.formatters_by_ft.lua = [ "stylua" ];
    lint.lintersByFt.lua = [ "selene" ];
  };
}
