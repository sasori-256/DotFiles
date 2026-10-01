{ pkgs, ... }:

let
  agentSocket =
    if pkgs.stdenv.hostPlatform.isDarwin then
      "~/Library/Group Containers/2BUA8C4S2C.com.1password/t/agent.sock"
    else
      "~/.1password/agent.sock";
in
{
  programs.ssh = {
    enable = true;
    enableDefaultConfig = false;

    # extraConfig ではなく includes を使う。
    # includes は globalConfig としてファイル先頭に出るので、
    # ローカルファイルのホスト個別設定が Host * に勝つ。
    # extraConfig は Host * より後ろに置かれるため、
    # IdentityAgent や ControlMaster の上書きが黙って無視される。
    # glob にしておくとファイルが無くても Include はエラーにならない。
    includes = [ "~/.ssh/config.d/*.conf" ];

    settings = {
      "github.com".User = "git";

      "*" = {
        IdentityAgent = ''"${agentSocket}"'';
        AddKeysToAgent = "no";
        ServerAliveInterval = 60;
        ServerAliveCountMax = 3;
        StrictHostKeyChecking = "accept-new";
        ControlMaster = "auto";
        ControlPath = "~/.ssh/control/%C";
        ControlPersist = "10m";
      };
    };
  };

  home.file = {
    ".ssh/control/.keep".text = "";
    ".ssh/config.d/.keep".text = "";
    # IdentityFile + IdentitiesOnly で「このホストではこの鍵だけ試す」と
    # エージェントに指示するためにこのファイルが必要。
    ".ssh/homelab-admin.pub".text = ''
      ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAILEc+rIJl0NXcd7E8RCbaaFNq3rR9i4y6uqEefIjAbCH homelab-admin
    '';
  };
}
