{ pkgs, username, ... }:

{
  # Disable NixOS 22.11 and later's automatic documentation generation
  # to avoid nixvim's conflict with
  # "nixos-render-docs manual html: error: --toc-depth has been removed, …"
  documentation.enable = false;

  environment.systemPackages = with pkgs; [
  ];

  system = {
    activationScripts.preActivation.text = ''
      if [ -f /etc/nix/nix.conf ]; then
        mv /etc/nix/nix.conf /etc/nix/nix.conf.before-nix-darwin || true;
      fi
    '';

    # Rosetta 2 を未インストールなら入れる（x86_64 macOS バイナリ実行のため）
    activationScripts.extraActivation.text = ''
      if ! /usr/bin/arch -x86_64 /usr/bin/true 2>/dev/null; then
        echo "Installing Rosetta 2..."
        /usr/sbin/softwareupdate --install-rosetta --agree-to-license
      fi
    '';

    primaryUser = username;

    stateVersion = 4;

    defaults = {
      # Finder
      finder = {
      };

      # Dock
      dock = {
      };

      # Global settings
      NSGlobalDomain = {
      };

      # Control Center
      controlcenter = {
      };

      # Trackpad
      trackpad = {
      };
    };
  };

  nix = {
    settings = {
      experimental-features = "nix-command flakes";
      extra-platforms = [ "x86_64-darwin" ];
      substituters = [ "https://devenv.cachix.org" ];
      trusted-users = [
        "root"
        "${username}"
      ];
      trusted-public-keys = [
        "devenv.cachix.org-1:w1cLUi8dv3hnoSPGAuibQv+f9TZLr6cv/Hm9XgU50cw="
      ];
    };
    package = pkgs.nix;

    # Garbage Collection of Nix
    gc = {
      automatic = true;
      interval = {
        Day = 7;
      };
      options = "--delete-older-than 30d";
    };
  };

  nixpkgs = {
    config.allowUnfree = true;
    hostPlatform = "aarch64-darwin";
  };

  environment.variables = {
    EDITOR = "nvim";
  };

  ids.gids.nixbld = 350;

  security.pam.services.sudo_local.touchIdAuth = true;

  programs.zsh.enable = true;
  users.users.${username}.shell = pkgs.zsh;

  # Homebrew for GUI installation
  homebrew = {
    enable = true;
    onActivation = {
      # 最新バージョンのHomebrewでcleanupにforce、force-cleanupが必要になったため、いったんオフ
      cleanup = "none";
      autoUpdate = true;
      upgrade = true;
    };
    casks = [
      "raycast"
      "visual-studio-code"
      "1password"
      "wezterm"
      "brave-browser"
      "claude"
      "azookey"
      "github"
      "orbstack"
      "windows-app"
      "tailscale"
      "obsidian"
    ];
  };
}
