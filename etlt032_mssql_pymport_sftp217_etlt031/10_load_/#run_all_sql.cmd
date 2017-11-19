@echo off
echo %cd%
echo.

python3 mssql_pymport.py
echo.

if exist ..\..\setup_env.cmd call ..\..\setup_env.cmd
if exist ..\setup_env.cmd call ..\setup_env.cmd

echo %username% > %log%
for %%f in (*.sql) do call mssql_run.cmd  %%f
echo. >> %log%
%check_log%

rem pause
