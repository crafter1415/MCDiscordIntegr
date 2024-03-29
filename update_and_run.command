#!/bin/sh
DIR=$(dirname "$0")
cd "$DIR"
# 
# 必要がある場合はここでjava本体とjvm引数を指定してください
# 
JAVA="java"
JVM_ARGS="-Xms4G -Xmx4G"
#
# [重要] 現在名前に空白を含むディレクトリでの実行をサポートしていません
# 
# 仕様上本ファイルの実行にアクセス権が要求される場合があります。
# その場合は本ソースコードをサーバーディレクトリに配置した後に配置したディレクトリで以下のコマンドを実行してください: 
#   chmod u+x ./update_and_run.sh
# システムエンコードと本ファイルのエンコードが異なる場合文字化けを起こす可能性があります
# その際はお手数ですが手動でエンコードを行ってください
#
# 以下自動アップデート用コード
# 
mkdir .work
rm .work/version.remote
curl https://raw.githubusercontent.com/crafter1415/MCDiscordIntegr/main/version.info -Lo .work/version.remote
if [ ! -e .work/version.remote ]; then
  if [ ! -e mcdi.jar ]; then
    echo "[AutoUpdate] 初期化に失敗しました"
    exit 1
  fi
  echo "[AutoUpdate] リモートのバージョンの確認に失敗しました"
  echo "[AutoUpdate] 更新をスキップします"
else
  for i in 0
  do
    if [ -e .work/version.info ]; then
      diff -s .work/version.remote .work\version.info > /dev/null 2>&1
      if [ $? -eq 0 ]; then
        rm .work/version.remote
        echo "[AutoUpdate] 本バージョンは最新バージョンです"
        echo "[AutoUpdate] バージョン確認を終了します"
        break
      fi
    fi
    mv .work/version.remote version.info
    rm mcdi.jar
    rm update.log
    curl https://raw.githubusercontent.com/crafter1415/MCDiscordIntegr/main/mcdi.jar -Lo mcdi.jar
    curl https://raw.githubusercontent.com/crafter1415/MCDiscordIntegr/main/update.log -Lo update.log
    echo "[AutoUpdate] 自動アップデートが完了しました"
    echo "[AutoUpdate] 更新情報 :"
    cat .work/version.info
    echo ""
  done
fi
$JAVA $JVM_ARGS -jar mcdi.jar nogui
exit 0
