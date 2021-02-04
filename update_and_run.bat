@rem ## 必要がある場合はここでjava本体とjvm引数を指定してください
@set JAVA=java
@set JAVA_ARGS=-Xms2G -Xmx4G
@rem ## システムエンコードと本ファイルのエンコードが異なる場合文字化けを起こす可能性があります
@rem ## その際はお手数ですが手動でエンコードを行ってください
@rem ##
@rem ## 以下自動アップデート用コード
@rem ## --------------------------------------------------------------

@rem ## 敢えて触れませんでしたが最初に@echo offせずに@を付けて隠すスタイル
@rem ## 何回も見かけてますが謎です。何か理由でもあるんですかね?
@echo off
setlocal EnableDelayedExpansion
cd %~dp0
if not exist .work (
    md .work
    attrib .work +h
)
if exist .work\version.remote del .work\version.remote
bitsadmin /cancel check_remote >nul
start /min /wait "" bitsadmin /transfer check_remote https://raw.githubusercontent.com/crafter1415/MCDiscordIntegr/main/version.info "%~dp0\.work\version.remote"
if not exist .work\version.remote (
    if not exist mcdi.jar (
        echo [AutoUpdate] 初期化に失敗しました
        pause
        exit /b 1
    )
    echo [AutoUpdate] リモートのバージョンの確認に失敗しました
    echo [AutoUpdate] 更新をスキップします
    goto :skipupdate
)
if not exist .work\version.info goto :skipcheck
fc .work\version.remote .work\version.info >nul
if %errorlevel% equ 1 (
    del .work\version.info
) else (
    del .work\version.remote
    echo [AutoUpdate] 本バージョンは最新バージョンです
    echo [AutoUpdate] バージョン確認を終了します
    goto :skipupdate
)
:skipcheck
ren .work\version.remote version.info
if exist mcdi.jar del mcdi.jar
if exist update.log del update.log
bitsadmin /cancel mcdi >nul
bitsadmin /cancel log >nul
start /min /wait "" bitsadmin /transfer mcdi https://raw.githubusercontent.com/crafter1415/MCDiscordIntegr/main/version.info "%~dp0\mcdi.jar"
start /min /wait "" bitsadmin /transfer log https://raw.githubusercontent.com/crafter1415/MCDiscordIntegr/main/version.info "%~dp0\update.log"
echo [AutoUpdate] 自動アップデートが完了しました
echo [AutoUpdate] 更新情報 :
type .work\version.info
echo.
:skipupdate
%JAVA% %JAVA_ARGS% -jar mcdi.jar
pause
endlocal
exit /b 0
