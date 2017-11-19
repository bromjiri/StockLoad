
--use no_need_to_setup_or_change
go


        print  'START :: [etlt032].[load__rc_rd_fe_document_1498044600]'
        go
        BEGIN
          bulk insert [etlt032].[load__rc_rd_fe_document_1498044600]
          from 'c:\users\jbrom\pycharmprojects\stockload\etlt031_etl_processing_etlt030\_02_rc_recode_to_utf16le\_rc_rd_fe_document_1498044600.csv'
          with (
               firstrow        = 2                 -- expecting 2 if header present, 1 if no header present
             , codepage        = 'utf-16'           -- '1252' '1250'
             , datafiletype    = 'widechar'         -- 'char'
             , fieldterminator = '	'               -- '^' ';' '\t'
             , rowterminator   = '\n'               -- '\n'
             , errorfile       = 'C:\Users\jbrom\PycharmProjects\StockLoad\etlt031_etl_processing_etlt030\_02_rc_recode_to_utf16le\import.err.load__rc_rd_fe_document_1498044600'  -- error file name
             , tablock         -- speeds up the bulk insert; it locks the table as a whole
          );
        END
        
--use no_need_to_setup_or_change
go


        print  'START :: [etlt032].[load__rc_rd_fe_vega_1498044600]'
        go
        BEGIN
          bulk insert [etlt032].[load__rc_rd_fe_vega_1498044600]
          from 'c:\users\jbrom\pycharmprojects\stockload\etlt031_etl_processing_etlt030\_02_rc_recode_to_utf16le\_rc_rd_fe_vega_1498044600.csv'
          with (
               firstrow        = 2                 -- expecting 2 if header present, 1 if no header present
             , codepage        = 'utf-16'           -- '1252' '1250'
             , datafiletype    = 'widechar'         -- 'char'
             , fieldterminator = '	'               -- '^' ';' '\t'
             , rowterminator   = '\n'               -- '\n'
             , errorfile       = 'C:\Users\jbrom\PycharmProjects\StockLoad\etlt031_etl_processing_etlt030\_02_rc_recode_to_utf16le\import.err.load__rc_rd_fe_vega_1498044600'  -- error file name
             , tablock         -- speeds up the bulk insert; it locks the table as a whole
          );
        END
        
--use no_need_to_setup_or_change
go


        print  'START :: [etlt032].[load__rc_rd_fe_vega_document_1498044600]'
        go
        BEGIN
          bulk insert [etlt032].[load__rc_rd_fe_vega_document_1498044600]
          from 'c:\users\jbrom\pycharmprojects\stockload\etlt031_etl_processing_etlt030\_02_rc_recode_to_utf16le\_rc_rd_fe_vega_document_1498044600.csv'
          with (
               firstrow        = 2                 -- expecting 2 if header present, 1 if no header present
             , codepage        = 'utf-16'           -- '1252' '1250'
             , datafiletype    = 'widechar'         -- 'char'
             , fieldterminator = '	'               -- '^' ';' '\t'
             , rowterminator   = '\n'               -- '\n'
             , errorfile       = 'C:\Users\jbrom\PycharmProjects\StockLoad\etlt031_etl_processing_etlt030\_02_rc_recode_to_utf16le\import.err.load__rc_rd_fe_vega_document_1498044600'  -- error file name
             , tablock         -- speeds up the bulk insert; it locks the table as a whole
          );
        END
        