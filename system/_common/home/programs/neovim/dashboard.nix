{ ... }:

{
  extraConfigLuaPre = "vim.g._start_time = vim.uv.hrtime()";

  plugins.snacks.settings = {
    dashboard = {
      enable = true;
      preset.header = ''
        ███████╗██████╗ ███████╗ █████╗ ██╗  ██╗██╗
        ██╔════╝██╔══██╗██╔════╝██╔══██╗██║ ██╔╝██║
        ███████╗██████╔╝█████╗  ███████║█████╔╝ ██║
        ╚════██║██╔═══╝ ██╔══╝  ██╔══██║██╔═██╗ ██║
        ███████║██║     ███████╗██║  ██║██║  ██╗██║
        ╚══════╝╚═╝     ╚══════╝╚═╝  ╚═╝╚═╝  ╚═╝╚═╝
      '';
      sections = [
        {
          pane = 1;
          section = "terminal";
          cmd = "chafa ~/Downloads/supiki.webp --size 50 --symbols vhalf";
          height = 30;
          padding = 1;
          ttl = 300;
          indent = 3;
        }
        {
          pane = 1;
          __raw = ''
            function()
              local start = vim.g._start_time or vim.uv.hrtime()
              local ms = (vim.uv.hrtime() - start) / 1e6
              local v = vim.version()
              return {{
                text = {{
                  string.format(" v%d.%d.%d  |  ⏱  %.0fms  |  📅  %s",
                    v.major, v.minor, v.patch, ms, os.date("%Y-%m-%d")),
                  "SnacksDashboardFooter",
                }},
                align = "center",
                padding = 1,
              }}
            end
          '';
        }
        {
          pane = 2;
          section = "header";
        }
        {
          pane = 2;
          section = "keys";
          gap = 1;
          padding = 1;
        }
        {
          pane = 2;
          section = "recent_files";
          cwd = true;
          padding = 1;
        }
        {
          pane = 2;
          section = "projects";
          padding = 1;
        }
      ];
    };
  };
}
