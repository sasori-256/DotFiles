{ ... }:

# Per-language parsers, LSP servers, formatters and linters
{
  imports = [
    ./cpp.nix
    ./java.nix
    ./lua.nix
    ./markdown.nix
    ./misc.nix
    ./nix.nix
    ./python.nix
    ./scheme.nix
    ./web.nix
    ./yaml.nix
  ];
}
