{
  description = "Nix flake for macOS and Linux system configuration using Darwin System";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin = {
      url = "github:LnL7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixvim.url = "github:nix-community/nixvim";
  };
  outputs =
    {
      self,
      nixpkgs,
      nix-darwin,
      home-manager,
      nixvim,
    }:
    let
      lib = nixpkgs.lib;
      df-root = path: ./../${path};

      mkDarwinSystem =
        { hostname, username }:
        nix-darwin.lib.darwinSystem {
          system = "aarch64-darwin";
          modules = [
            # Packages shared with every user
            ./darwin/_common/system.nix
            # Packages bound each user
            ./darwin/${hostname}/system.nix
            home-manager.darwinModules.home-manager
            {
              networking.hostName = hostname;
              users.users.${username}.home = "/Users/${username}";

              home-manager.useUserPackages = true;
              home-manager.backupFileExtension = "backup";

              home-manager.users.${username} = {
                imports = [
                  ./darwin/_common/home
                  ./darwin/${hostname}/home.nix
                ];
              };

              home-manager.sharedModules = [
                nixvim.homeModules.nixvim
                {
                  _module.args = {
                    inherit
                      lib
                      username
                      hostname
                      df-root
                      ;
                  };

                  programs.nixvim.nixpkgs.source = nixvim.inputs.nixpkgs;

                  nixpkgs.config.allowUnfree = true;

                  nixpkgs.overlays = [
                    (final: prev: {
                      moralerspace = prev.callPackage (df-root "fonts/moralerspace/default.nix") { };
                    })
                  ];
                }
              ];
            }
          ];
          specialArgs = {
            inherit (nixpkgs) lib;
            inherit username hostname df-root;
          };
        };
    in
    {
      darwinConfigurations.hirasaka46 = mkDarwinSystem {
        hostname = "hirasaka46";
        username = "sasori";
      };
    };
}
