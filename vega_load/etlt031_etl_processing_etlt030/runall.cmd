@echo off

set l031=etlt031.log
set d031=%cd%

echo %DATE% %TIME% - etlt031_etl_processing_etlt030 start >> %l031%
echo %username% >> %l031%

cd %d031%\_00_fe_fix_eols
echo %DATE% %TIME% - _00_fe_fix_eols start >> %l031%
call run.cmd >> %l031%
echo %DATE% %TIME% - _00_fe_fix_eols end >> %l031%


cd %d031%\_01_rd_replace_delimiters
echo %DATE% %TIME% - _01_rd_replace_delimiters start >> %l031%
call run.cmd >> %l031%
echo %DATE% %TIME% - _01_rd_replace_delimiters end >> %l031%


cd %d031%\_02_rc_recode_to_utf16le
echo %DATE% %TIME% - _02_rc_recode_to_utf16le start >> %l031%
call run.cmd >> %l031%
echo %DATE% %TIME% - _02_rc_recode_to_utf16le end >> %l031%


cd %d031%
echo %DATE% %TIME% - etlt031_etl_processing_etlt030 end >> %l031%
echo. >> %l031%
