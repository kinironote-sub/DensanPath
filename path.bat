@echo off
if not "%COMPUTERNAME:PCROOM_=%" == "%COMPUTERNAME%" (
	rem fden
	echo 第一電算室及び第二電算室用のスクリプトを実行します。
	echo pythonをインストールするためにネットワーク接続が必要です。ネットワーク認証を行ってください。
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
	echo 終了。
) else (
	rem jden
	echo J電算用のスクリプトを実行します。
	echo;

	rem 妥協。元path内に「"」でエスケープ出来ない特殊文字が含まれると死ぬ。
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
	rem 注．INCLUDEとLIBはめんどいので上書きしてる。現時点では存在していないので問題なし
	setx INCLUDE "C:\Program Files (x86)\Microsoft Visual Studio 14.0\VC\include;C:\Program Files (x86)\Windows Kits\10\Include\10.0.10240.0\ucrt"
	setx LIB "C:\Program Files (x86)\Microsoft Visual Studio 14.0\Common7\IDE;C:\Program Files (x86)\Microsoft SDKs\Windows\v7.1A\Lib\x86;C:\Program Files (x86)\Microsoft Visual Studio 14.0\VC\lib;C:\Program Files (x86)\Windows Kits\10\Lib\10.0.10240.0\ucrt\x86;C:\Program Files (x86)\Windows Kits\8.1\Lib\winv6.3\um\x86"

	rem path to python
	set compile_path="%compile_path%;C:\Users\TeamET\AppData\Local\Programs\Python\Python35-32;C:\Users\TeamET\AppData\Local\Programs\Python\Python35-32\Scripts"
	set compile_path=%compile_path:"=%

	setx path "%new_path%;%compile_path%"

)
