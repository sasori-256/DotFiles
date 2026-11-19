{ ... }:

{
  plugins = {
    treesitter.settings.ensure_installed = [
      "c"
      "cpp"
      "cmake"
    ];

    lsp.servers = {
      clangd = {
        enable = true;
        cmd = [
          "clangd"
          "--background-index"
          "--clang-tidy"
          "--completion-style=detailed"
          "--header-insertion=iwyu"
          "--pch-storage=memory"
        ];
      };
      cmake.enable = true;
    };

    clangd-extensions = {
      enable = true;
      enableOffsetEncodingWorkaround = true;
    };

    cmake-tools = {
      enable = true;
      settings = {
        cmake_build_directory = "build";
        cmake_soft_link_compile_commands = true;
        cmake_generate_options.__raw = ''{ "-DCMAKE_EXPORT_COMPILE_COMMANDS=1" }'';
      };
    };
  };
}
