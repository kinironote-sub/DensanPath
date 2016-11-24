@echo off

if not "%COMPUTERNAME:PCROOM_=%" == "%COMPUTERNAME%" (
    echo 第一電算室及び第二電算室用に設定しています…
    call :YDEN_SET_PATH
) else (
    echo J電算用に設定しています…
    call :JDEN_SET_PATH
)
echo;
echo 終了。
exit /b


:YDEN_SET_PATH
rem path to python
set compile_path=C:\pleiades\python\3;C:\pleiades\python\3\Scripts
setx path "%compile_path%"
rem upgrade pip
C:\pleiades\python\3\python -m pip install --upgrade pip
exit /b


:JDEN_SET_PATH
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

rem path to vc++ それっぽいの適当につっこむ
set compile_path="%compile_path%;C:\Program Files (x86)\Microsoft SDKs\Windows\v7.1A\Lib\x64;C:\Program Files (x86)\Microsoft Visual Studio 14.0\Common7\IDE;C:\Program Files (x86)\Microsoft Visual Studio 14.0\VC\bin"
set compile_path=%compile_path:"=%
rem 注．INCLUDEとLIBはめんどいので上書きしてる。現時点では存在していないので問題なし
setx INCLUDE "C:\Program Files (x86)\Microsoft Visual Studio 14.0\VC\include;C:\Program Files (x86)\Windows Kits\10\Include\10.0.10240.0\ucrt"
setx LIB "C:\Program Files (x86)\Microsoft Visual Studio 14.0\Common7\IDE;C:\Program Files (x86)\Microsoft SDKs\Windows\v7.1A\Lib\x86;C:\Program Files (x86)\Microsoft Visual Studio 14.0\VC\lib;C:\Program Files (x86)\Windows Kits\10\Lib\10.0.10240.0\ucrt\x86;C:\Program Files (x86)\Windows Kits\8.1\Lib\winv6.3\um\x86"

rem path to python
set compile_path="%compile_path%;C:\Users\TeamET\AppData\Local\Programs\Python\Python35-32;C:\Users\TeamET\AppData\Local\Programs\Python\Python35-32\Scripts"
set compile_path=%compile_path:"=%

setx originpath "%compile_path%"
setx path "%new_path%;%%originpath%%"
exit /b