@rem ## �K�v������ꍇ�͂�����java�{�̂�jvm�������w�肵�Ă�������
@set JAVA=java
@set JVM_ARGS=-Xms2G -Xmx4G
@rem ## �V�X�e���G���R�[�h�Ɩ{�t�@�C���̃G���R�[�h���قȂ�ꍇ�����������N�����\��������܂�
@rem ## ���̍ۂ͂��萔�ł����蓮�ŃG���R�[�h���s���Ă�������
@rem ##
@rem ## �ȉ������A�b�v�f�[�g�p�R�[�h
@rem ## --------------------------------------------------------------

@rem ## �����ĐG��܂���ł������ŏ���@echo off������@��t���ĉB���X�^�C��
@rem ## ������������Ă܂�����ł��B�������R�ł������ł�����?
@echo off
setlocal EnableDelayedExpansion
cd %~dp0
if not exist .work (
    md .work
    attrib .work +h
)
if exist .work\version.remote del .work\version.remote
curl -L https://raw.githubusercontent.com/crafter1415/MCDiscordIntegr/main/version.info  -o .\.work\version.remote
if not exist .work\version.remote (
    if not exist mcdi.jar (
        echo [AutoUpdate] �������Ɏ��s���܂���
        pause
        exit /b 1
    )
    echo [AutoUpdate] �����[�g�̃o�[�W�����̊m�F�Ɏ��s���܂���
    echo [AutoUpdate] �X�V���X�L�b�v���܂�
    goto :skipupdate
)
if not exist .work\version.info goto :skipcheck
fc .work\version.remote .work\version.info >nul
if %errorlevel% equ 1 (
    del .work\version.info
) else (
    del .work\version.remote
    echo [AutoUpdate] �{�o�[�W�����͍ŐV�o�[�W�����ł�
    echo [AutoUpdate] �o�[�W�����m�F���I�����܂�
    goto :skipupdate
)
:skipcheck
ren .work\version.remote version.info
if exist mcdi.jar del mcdi.jar
if exist update.log del update.log
curl -L https://raw.githubusercontent.com/crafter1415/MCDiscordIntegr/main/mcdi.jar -o .\mcdi.jar
curl -L https://raw.githubusercontent.com/crafter1415/MCDiscordIntegr/main/update.log -o .\update.log
echo [AutoUpdate] �����A�b�v�f�[�g���������܂���
echo [AutoUpdate] �X�V��� :
type .work\version.info
echo.
:skipupdate
%JAVA% %JVM_ARGS% -jar mcdi.jar
pause
endlocal
exit /b 0
