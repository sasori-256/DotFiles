{ pkgs, username, ... }:

{
  environment.systemPackages = with pkgs; [
  ];

  system.activationScripts.preActivation.text = ''
    if [ -f /etc/nix/nix.conf ]; then
      mv /etc/nix/nix.conf /etc/nix/nix.conf.before-nix-darwin || true;
    fi
  '';

  # Rosetta 2 を未インストールなら入れる（x86_64 macOS バイナリ実行のため）
  system.activationScripts.extraActivation.text = ''
    if ! /usr/bin/arch -x86_64 /usr/bin/true 2>/dev/null; then
      echo "Installing Rosetta 2..."
      /usr/sbin/softwareupdate --install-rosetta --agree-to-license
    fi
  '';

  nix.settings = {
    experimental-features = "nix-command flakes";
    extra-platforms = [ "x86_64-darwin" ];
    substituters = [ "https://devenv.cachix.org" ];
    trusted-public-keys = [
      "devenv.cachix.org-1:w1cLUi8dv3hnoSPGAuibQv+f9TZLr6cv/Hm9XgU50cw="
    ];
  };
  nix.package = pkgs.nix;
  nixpkgs.config.allowUnfree = true;
  nixpkgs.hostPlatform = "aarch64-darwin";

  # Garbage Collection of Nix
  nix.gc = {
    automatic = true;
    interval = {
      Day = 7;
    };
    options = "--delete-older-than 30d";
  };

  system.primaryUser = username;

  environment.variables = {
    EDITOR = "nvim";
  };

  system.stateVersion = 4;
  ids.gids.nixbld = 350;

  security.pam.services.sudo_local.touchIdAuth = true;

  programs.zsh.enable = true;
  users.users.${username}.shell = pkgs.zsh;

  # Finder
  system.defaults.finder = {
  };

  # Dock
  system.defaults.dock = {
  };

  # Global settings
  system.defaults.NSGlobalDomain = {
  };

  # Control Center
  system.defaults.controlcenter = {
  };

  # Trackpad
  system.defaults.trackpad = {
  };

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
