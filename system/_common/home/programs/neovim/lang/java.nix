{ ... }:

{
  plugins = {
    treesitter.settings.ensure_installed = [ "java" ];

    lsp.servers.jdtls = {
      enable = true;
      extraOptions = {
        # Per-project workspace: cache/jdtls/<project-name>
        cmd.__raw = ''
          {
            "jdtls",
            "--data=" .. vim.fn.stdpath("cache") .. "/jdtls/" ..
              vim.fn.fnamemodify(vim.fn.getcwd(), ":t"),
          }
        '';
        # Register $JAVA_HOME (set per project by devenv) under the name
        # matching its actual version; a mismatched name is ignored by jdtls.
        settings.java.configuration.runtimes.__raw = ''
          (function()
            local h = vim.env.JAVA_HOME
            if not h or h == "" then return {} end
            local f = io.open(h .. "/release")
            if not f then return {} end
            local v = f:read("*a"):match('JAVA_VERSION="([^"]+)"')
            f:close()
            if not v then return {} end
            local major = v:match("^1%.(%d+)") or v:match("^(%d+)")
            local name = major == "8" and "JavaSE-1.8" or ("JavaSE-" .. major)
            return {{ name = name, path = h, default = true }}
          end)()
        '';
      };
    };
  };
}
