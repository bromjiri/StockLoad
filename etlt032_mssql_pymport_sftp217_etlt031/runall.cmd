@echo off

echo %DATE% %TIME% - etlt032_mssql_pymport_sftp217_etlt031 start
set d032=%cd%

cd %d032%\10_load_
call #run_all_sql.cmd

cd %d032%\30_staging_
call #run_all_sql.cmd

cd %d032%
echo %DATE% %TIME% - etlt032_mssql_pymport_sftp217_etlt031 end