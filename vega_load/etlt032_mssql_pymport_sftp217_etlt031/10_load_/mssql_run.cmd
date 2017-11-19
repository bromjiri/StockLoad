@echo off

if exist ..\..\setup_env.cmd call ..\..\setup_env.cmd
if exist ..\setup_env.cmd call ..\setup_env.cmd

echo %DATE% %TIME% %1
echo. >> %log%
echo %DATE% %TIME% %1 >> %log%
echo. >> %log%
%run_mssql% %1 >> %log%

