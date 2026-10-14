{ ... }:

{
  # Neovim の minuet (コード補完) のバックエンド。launchd agent として常駐する。
  # モデルは activation の中でダウンロードさせると switch が固まるので、初回に手で取得する:
  #   ollama pull qwen2.5-coder:7b
  services.ollama = {
    enable = true; # 127.0.0.1:11434
    environmentVariables = {
      OLLAMA_KEEP_ALIVE = "30m"; # 短いとモデルのロード待ちで最初の補完が遅くなる
    };
  };
}
