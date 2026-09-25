_:

let
  # 1Password の SSH 鍵。この鍵を差し替えたら GitHub 側で Authentication Key と
  # Signing Key の両方に登録し直すこと。GitHub は同じ公開鍵でも別物として扱うので、
  # Authentication Key だけだと push は通るのにコミットが Unverified のままになる
  # （ローカルは allowed_signers を持っているので `git log --show-signature` は Good と出る）。
  #   gh auth refresh -h github.com -s admin:ssh_signing_key
  #   gh api --method POST /user/ssh_signing_keys -f title=... -f key=...
  signingKey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIHD0yfaaR4biXau0lsvSkungOTqJ0PY0MJ3Y5NXL3yI/";
  noreply-email = "72808408+sasori-256@users.noreply.github.com";
in
{
  programs.git = {
    enable = true;
    lfs.enable = true;

    signing = {
      key = signingKey;
      signByDefault = true;
    };

    settings = {
      user = {
        name = "黄泉比良坂46(むつみん)";
        email = noreply-email;
      };
      gpg = {
        format = "ssh";
        ssh = {
          program = "/Applications/1Password.app/Contents/MacOS/op-ssh-sign";
          allowedSignersFile = "~/.ssh/allowed_signers";
        };
      };
    };
  };

  # gpg.ssh.allowedSignersFile の実体。これが無いと
  # `git log --show-signature` でのローカル検証が落ちる
  # （GitHub 側の Verified 表示には影響しない）。
  # 1Password は allowed_signers を自動生成しないので自分で作る。
  home.file.".ssh/allowed_signers".text = ''
    ${noreply-email} ${signingKey}
  '';
}
