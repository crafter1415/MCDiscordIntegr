# MCDiscordIntegr
β版。サポートは致しかねます。

## 使い方

### 自動アップデートなしで利用する場合

起動スクリプトは他サイトの物を参照し、その中の `server.jar` の部分を `mcdi.jar` に変更してください。

### Windowsにて自動アップデートありで利用する場合

[ここ](https://github.com/crafter1415/MCDiscordIntegr/raw/main/update_and_run.bat)からダウンロードしたファイルを `server.jar` のあるディレクトリに配置し、  
必要があればファイル内の変数 `JAVA` `JVM_ARGS` を変更してサーバー起動の際に実行してください。

### MacやLinuxにて自動アップデートありで利用する場合

**必要なもの： wget**
インストールには Homebrew を利用するのが手っ取り早いです。   
Homebrew のインストール方法に関しては長くなり趣旨から外れるので割愛します。  
  
[ここ](https://github.com/crafter1415/MCDiscordIntegr/raw/main/update_and_run.command)からダウンロードしたファイルを `server.jar` のあるディレクトリに配置し、  
必要があればファイル内の変数 `JAVA` `JVM_ARGS` を変更してサーバー起動の際に実行してください。

## 使用ライブラリ

Discord連携: [JDA](https://github.com/DV8FromTheWorld/JDA)  
json関連: [Gson](https://github.com/google/gson)  
自動バックアップ: [Apache Commons Compress](https://github.com/apache/commons-compress), [XZ](https://github.com/tukaani-project/xz)  
GitHub連携: [JGit](https://www.eclipse.org/jgit/), [JSch(fork)](https://github.com/mwiede/jsch), [BouncyCastle](https://github.com/bcgit/bc-java)
