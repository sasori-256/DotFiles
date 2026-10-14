{
  config,
  pkgs,
  lib,
  username,
  ...
}:

{
  imports = [
    ../../../_common/home
    ./programs/linearmouse.nix
    ./programs/orca.nix
  ];

  home = {
    inherit username;
    homeDirectory = lib.mkForce "/Users/${username}";
    stateVersion = "24.11";
    sessionVariables = {
      ANDROID_HOME = "${config.home.homeDirectory}/Library/Android/sdk";
      ANDROID_SDK_ROOT = "${config.home.homeDirectory}/Library/Android/sdk";
    };
    sessionPath = [
      "/Users/${username}/.local/bin"
      # Homebrew。cask 管理は nix-darwin 経由で宣言的に行うので、
      # ここに通すのは brew 自体をデバッグ用に叩けるようにするため。
      # formula は入れない（CLI ツールは Nix に寄せる方針）。
      "/opt/homebrew/bin"
    ];
  };
  targets.darwin.linkApps.enable = true;
}
