
--use no_need_to_setup_or_change
go


        BEGIN
         alter table [etlt032].[load__rc_rd_fe_document_1498044600]
           add DT_LOAD_ID       int identity(1,1)
             , DT_LOAD_SOURCE_PATH  nvarchar(4000)
             , DT_LOAD_SOURCE_FILE  nvarchar(200);
        END
        go
        
        BEGIN
        update [etlt032].[load__rc_rd_fe_document_1498044600]
           set DT_LOAD_SOURCE_PATH    = 'C:\Users\jbrom\PycharmProjects\StockLoad\etlt031_etl_processing_etlt030\_02_rc_recode_to_utf16le\_rc_rd_fe_document_1498044600.csv'
           , DT_LOAD_SOURCE_FILE  = '_rc_rd_fe_document_1498044600.csv';
        END
        



        
--use no_need_to_setup_or_change
go


        BEGIN
         alter table [etlt032].[load__rc_rd_fe_vega_1498044600]
           add DT_LOAD_ID       int identity(1,1)
             , DT_LOAD_SOURCE_PATH  nvarchar(4000)
             , DT_LOAD_SOURCE_FILE  nvarchar(200);
        END
        go
        
        BEGIN
        update [etlt032].[load__rc_rd_fe_vega_1498044600]
           set DT_LOAD_SOURCE_PATH    = 'C:\Users\jbrom\PycharmProjects\StockLoad\etlt031_etl_processing_etlt030\_02_rc_recode_to_utf16le\_rc_rd_fe_vega_1498044600.csv'
           , DT_LOAD_SOURCE_FILE  = '_rc_rd_fe_vega_1498044600.csv';
        END
        



        
--use no_need_to_setup_or_change
go


        BEGIN
         alter table [etlt032].[load__rc_rd_fe_vega_document_1498044600]
           add DT_LOAD_ID       int identity(1,1)
             , DT_LOAD_SOURCE_PATH  nvarchar(4000)
             , DT_LOAD_SOURCE_FILE  nvarchar(200);
        END
        go
        
        BEGIN
        update [etlt032].[load__rc_rd_fe_vega_document_1498044600]
           set DT_LOAD_SOURCE_PATH    = 'C:\Users\jbrom\PycharmProjects\StockLoad\etlt031_etl_processing_etlt030\_02_rc_recode_to_utf16le\_rc_rd_fe_vega_document_1498044600.csv'
           , DT_LOAD_SOURCE_FILE  = '_rc_rd_fe_vega_document_1498044600.csv';
        END
        



        