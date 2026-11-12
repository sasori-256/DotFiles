---
name: kaggle-competition-setup
description: >-
  Kaggle コンペ用のプロジェクトディレクトリを devenv + direnv + uv で立ち上げ、コンペのデータセットを
  kaggle CLI でダウンロード・展開して配置する。「kaggleコンペのセットアップ」「コンペ用に環境を作って」
  「kaggle competitions download」「コンペのデータを入れて」などの依頼で使う。devenv / direnv / uv は
  グローバルに導入済みの前提。
---

# Kaggle コンペ セットアップ

コンペ用ディレクトリを、再現可能な Python 環境とデータ配置付きの状態にする。
作業は対象ディレクトリの中で行い、コミットはユーザーに頼まれたときだけ行う。

## 前提（確認のみ、無ければユーザーに伝える）

- `devenv`, `direnv`, `uv` が PATH にある。
- kaggle の認証が済んでいる（`~/.kaggle/` に資格情報がある）。
- コンペのルールに同意済み（参加登録済み）。未参加だと download が 403 になる。
- 入力: コンペの slug（コンペURL `https://www.kaggle.com/competitions/<slug>` の `<slug>`）と、
  セットアップ先ディレクトリ（指定がなければカレントディレクトリ）。

## 手順

### 1. 状態確認
- `git status` と既存ファイルを確認する。既に `devenv.nix` / `.envrc` / `pyproject.toml` があれば上書きせず、差分だけ足す。
- 既存の `data/` にデータがあれば、再ダウンロードの前にユーザーに確認する（数GBの場合がある）。

### 2. 環境ファイル
- `.envrc`: `use devenv` の 1 行。
- `devenv.yaml`: 既存がなければ `inputs: nixpkgs: url: github:cachix/devenv-nixpkgs/rolling` を書く。
- `devenv.nix`: テンプレートの `languages.rust` 等のコメントは残してよいが、次を有効にする。
  ```nix
  languages.python = {
    enable = true;
    version = "3.14";   # .python-version と揃える
    uv.enable = true;
  };
  ```
- `.python-version`: 上と同じ版を書く。
- `pyproject.toml`: 無ければ `uv init` で作り、`uv add kaggle` で kaggle CLI を依存に入れる。`requires-python` を `.python-version` と揃える。
- `.gitignore` に最低限次を含める（無ければ追記）:
  `.venv/`, `.devenv*`, `.direnv`, `data/`, `*.zip`, `*.csv`, `*.parquet`, `kaggle.json`, `.env`

### 3. 依存関係と direnv
- `uv sync` で `.venv` を作る（`uv.lock` があれば `uv sync --locked`）。
- `direnv allow` で `.envrc` を信頼させる。
- `devenv eval languages.python.version` で設定が評価できることを確認する（初回は nixpkgs の取得で時間がかかる）。
- `devenv.lock` は生成されるが、削除せず残す（再現性のため）。

### 4. データのダウンロード
- kaggle CLI は `.venv` 内にあり、グローバル PATH には無いことがある。`.venv/bin/kaggle` か `uv run kaggle` で呼ぶ。
- `data/` に移動してダウンロードする:
  `cd data && ../.venv/bin/kaggle competitions download -c <slug>`
  数GBになる場合があるので、タイムアウトに注意する（長めに取るか、バックグラウンド実行にする）。
- 展開前に `unzip -t <zip>` で整合性を確認し、`unzip -o <zip>` で展開してから zip を削除する。
- `ls -la data/` で中身（例: `train.parquet`, `test.parquet`, `sample_submission.csv`）を確認して報告する。
  ファイル名はコンペごとに違うので、決め打ちしない。

### 5. 検証と報告
- `uv run python -c "import kaggle"` などで Python 環境を確認する。
- 変更したファイル一覧、配置したデータのパスとサイズ、未実施の項目を報告する。
- コミットはしない（頼まれた場合のみ）。

## 注意点

- macOS には `timeout` コマンドが無い。タイムアウトは Bash ツールの timeout 引数で指定する。
- `kaggle competitions list -s <語>` で参加状況（`userHasEntered`）を確認できる。
- ダウンロードが 403 になったら、認証ではなくルール未同意を疑い、ユーザーにコンペページで同意してもらう。
- `data/` は大容量のため、コミット対象に含めない。
