{ ... }:

let
  signingKey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIHD0yfaaR4biXau0lsvSkungOTqJ0PY0MJ3Y5NXL3yI/";
  email = "72808408+sasori-256@users.noreply.github.com";
in
{
  programs.git = {
    enable = true;
    userName = "黄泉比良坂46(むつみん)";
    userEmail = email;

    signing = {
      key = signingKey;
      signByDefault = true;
    };

    extraConfig = {
      gpg.format = "ssh";
      gpg.ssh.allowedSignersFile = "~/.ssh/allowed_signers";
    };
  };

  programs.ssh = {
    enable = true;
    extraConfig = ''
      Host *
        IdentityAgent "~/Library/Group Containers/2BUA8C4S2C.com.1password/t/agent.sock"
    '';
  };

  home.file.".ssh/allowed_signers".text = ''
    ${email} ${signingKey}
  '';
}
