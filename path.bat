@echo off
if not "%COMPUTERNAME:PCROOM_=%" == "%COMPUTERNAME%" (
	rem fden
	echo ���d�Z���y�ё��d�Z���p�̃X�N���v�g�����s���܂��B
	echo python���C���X�g�[�����邽�߂Ƀl�b�g���[�N�ڑ����K�v�ł��B�l�b�g���[�N�F�؂��s���Ă��������B
	start http://www.yahoo.co.jp/
	pause
	echo;
	cd C:\users\Public\Downloads

	echo Download python...
	@powershell -NoProfile -ExecutionPolicy Bypass -Command "$d=new-object System.Net.WebClient;$d.Proxy.Credentials=[System.Net.CredentialCache]::DefaultNetworkCredentials;$d.DownloadFile('https://www.python.org/ftp/python/3.4.4/python-3.4.4.amd64.msi','python.msi')"
	
	echo Install python...
	rem (command of install : http://python.readthedocs.io/en/latest/using/windows.html)
	msiexec /i python.msi /qn
	
	echo Set path to python...
	setx PATH C:\Python34;C:\Python34\Scripts
	
	echo;
	echo �I���B
) else (
	rem jden
	echo J�d�Z�p�̃X�N���v�g�����s���܂��B
	echo;

	rem �Ë��B��path���Ɂu"�v�ŃG�X�P�[�v�o���Ȃ����ꕶ�����܂܂��Ǝ��ʁB
	rem get pass
	for /F "tokens=1,2,*" %%a in ('REG QUERY HKEY_CURRENT_USER\Environment /v "Path"') do (set old_path="%%c")
	set new_path=%old_path:"=%

	set compile_path=

	rem path to java
	set compile_path="%compile_path%;C:\PROGRA~1\Java\jdk1.8.0_77\bin"
	set compile_path=%compile_path:"=%

	rem path to c
	set compile_path="%compile_path%;C:\cygwin64\bin"
	set compile_path=%compile_path:"=%

	rem path to vc++
	set compile_path="%compile_path%;C:\Program Files (x86)\Microsoft SDKs\Windows\v7.1A\Lib\x64;C:\Program Files (x86)\Microsoft Visual Studio 14.0\Common7\IDE;C:\Program Files (x86)\Microsoft Visual Studio 14.0\VC\bin"
	set compile_path=%compile_path:"=%
	rem ���DINCLUDE��LIB�͂߂�ǂ��̂ŏ㏑�����Ă�B�����_�ł͑��݂��Ă��Ȃ��̂Ŗ��Ȃ�
	setx INCLUDE "C:\Program Files (x86)\Microsoft Visual Studio 14.0\VC\include;C:\Program Files (x86)\Windows Kits\10\Include\10.0.10240.0\ucrt"
	setx LIB "C:\Program Files (x86)\Microsoft Visual Studio 14.0\Common7\IDE;C:\Program Files (x86)\Microsoft SDKs\Windows\v7.1A\Lib\x86;C:\Program Files (x86)\Microsoft Visual Studio 14.0\VC\lib;C:\Program Files (x86)\Windows Kits\10\Lib\10.0.10240.0\ucrt\x86;C:\Program Files (x86)\Windows Kits\8.1\Lib\winv6.3\um\x86"

	rem path to python
	set compile_path="%compile_path%;C:\Users\TeamET\AppData\Local\Programs\Python\Python35-32;C:\Users\TeamET\AppData\Local\Programs\Python\Python35-32\Scripts"
	set compile_path=%compile_path:"=%

	setx path "%new_path%;%compile_path%"

)
