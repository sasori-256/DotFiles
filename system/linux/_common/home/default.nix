{ username, ... }:

{
  imports = [
    ../../../_common/home
  ];

  home = {
    inherit username;
    homeDirectory = "/home/${username}";
    sessionPath = [
      "/home/${username}/.local/bin"
    ];
  };

  # 非 NixOS ディストリ向け（XDG_DATA_DIRS や locale などを整える）
  targets.genericLinux.enable = true;

  # home.packages に入れたフォント（moralerspace）を fontconfig に見せる
  fonts.fontconfig.enable = true;
}
