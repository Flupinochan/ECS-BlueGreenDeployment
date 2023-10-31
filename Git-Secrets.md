# Git-Secrets

## 概要
ファイルに、機密情報が含まれる場合に、`git commit` できないようにする!  
設定ファイルに記載された正規表現にマッチした場合、`git commit` ができない!  
カスタム設定を備忘録として、記載しておく  
`--global` (デフォルト)設定をすれば楽!  
ソース : [git-secrets](https://github.com/awslabs/git-secrets)


## Windowsでのインストール手順
PowerShellにて、下記を実行
```
git clone https://github.com/awslabs/git-secrets.git
cd git-secrets
./install.ps1
```


## Global機密情報設定ファイル
Global機密情報設定ファイルは、下記コマンドで確認可能  
※環境により場所が異なるため、コマンドで確認しておくこと
```
git config --global --list --show-origin
```

Global機密情報設定ファイルの場所
```
~/.gitconfig
```
リポジトリごとの機密情報設定ファイルの場所
```
your-local-repository/.git/config
```


## Global機密情報設定
`git secrets --install` 実行時に、デフォルトで設定される  
下記は、AWS機密情報検出用  
実行した後、下記、正規表現が `~/.gitconfig` に記載される  
※`--add` コマンドで追加するのは、私のカスタム設定で、AWSリソースのARNも検出されるようにしました!  
```
git secrets --register-aws --global
git secrets --add --global 'arn:[a-z0-9-]+:[a-z0-9-]+:[a-z0-9-]*:[0-9]+:[a-zA-Z0-9-]+'
git secrets --add --global 'arn:[a-z0-9-]+:[a-z0-9-]+:[a-z0-9-]*:[0-9]+:[a-zA-Z0-9-]+\/[a-zA-Z0-9-]+'
git secrets --add --global 'arn:[a-z0-9-]+:[a-z0-9-]+:[a-z0-9-]*:[0-9]+:[a-zA-Z0-9-]+:[a-zA-Z0-9-]+'
```


## リポジトリで git-secrets を有効化する手順
`git clone` した後は、必ず実行しよう!
```
cd your-local-repository
git secrets --install
```


## 備忘録用コマンド、オプション
すでに `git commit` してしまったコミットをチェックしたい場合  
```
git secrets --scan-history
```

機密情報設定を上書き (再インストール) したい場合  
```
git secrets --install -f
```

現在設定されている機密情報を標準出力して、確認したい場合  
※直接設定ファイルを確認したい場合 → [Global機密情報設定ファイル](#global機密情報設定ファイル)
```
git config --list --global
git config --list
```

機密情報を追加したい場合  
※`--global`オプションを付けない場合、カレント リポジトリにしか適用されないので注意する
```
git secrets --add 正規表現
git secrets --add --global 正規表現
```

逆に、特定のパターンを許可したい場合
```
git secrets --add -a 正規表現
```

推奨されるAWS機密情報を追加したい場合
```
git secrets --register-aws --global
```

AWS credentialsファイルのアクセスキー、シークレットアクセスキーを追加したい場合  
```
git secrets --aws-provider [credentials-file-path]
```

機密情報を削除したい場合、設定ファイルから手動で削除するしかありません...  
→ [Global機密情報設定ファイル](#global機密情報設定ファイル)

## おまけ
`git clone` 時に、自動で `git secrets --install` したい!  
`init.templatedir` を利用する!  
※ `init.templatedir` は、`git init` や `git clone` 時に、`git hooks` を作成してくれる!  
※ `git hooks` とは、Gitの特定のコマンドの前後で処理をさせたい時に利用する!  
(`git secrets` は、 `git hooks` を利用したもの)  
<br>
下記は、設定方法

```
git secrets --install ~/.git-templates/git-secrets
git config --global init.templateDir ~/.git-templates/git-secrets
```

`git clone` 時に、`ローカルリポジトリ\.git\hooks\` に、下記ファイルが作成されればok!

```
commit-msg
pre-commit
prepare-commit-msg
```