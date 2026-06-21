{ ... }:

let
  signingKey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIHD0yfaaR4biXau0lsvSkungOTqJ0PY0MJ3Y5NXL3yI/";
  email = "72808408+sasori-256@users.noreply.github.com";
in
{
  programs.git = {
    enable = true;

    signing = {
      key = signingKey;
      signByDefault = true;
    };

    settings = {
      user.name  = "黄泉比良坂46(むつみん)";
      user.email = email;
      gpg.format = "ssh";
      gpg.ssh.allowedSignersFile = "~/.ssh/allowed_signers";
    };
  };

  programs.ssh = {
    enable = true;
    enableDefaultConfig = false;
    settings."*" = {
      IdentityAgent = "~/Library/Group Containers/2BUA8C4S2C.com.1password/t/agent.sock";
      AddKeysToAgent = "no";
      ServerAliveInterval = 60;
      ServerAliveCountMax = 3;
      StrictHostKeyChecking = "accept-new";
      ControlMaster = "auto";
      ControlPath = "~/.ssh/control/%C";
      ControlPersist = "10m";
    };
    matchBlocks."github.com".user = "git";
  };

  home.file.".ssh/control/.keep".text = "";

  home.file.".ssh/allowed_signers".text = ''
    ${email} ${signingKey}
  '';
}
