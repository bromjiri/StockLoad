--use no_need_to_setup_or_change
go
--create schema ['etlt032']

    --use no_need_to_setup_or_change
    go

    if not exists (select schema_name from information_schema.schemata where schema_name = 'etlt032' ) 
    begin
        exec sp_executesql N'create schema etlt032'
    end
    


    update [etlt032].[load__rc_rd_fe_document_1498044600] 
      set [DT_FNAME|DOCUMENT_ID] = ltrim(rtrim( [DT_FNAME|DOCUMENT_ID] ))
        , [TIME] = ltrim(rtrim( [TIME] ))
        , [LANGUAGE] = ltrim(rtrim( [LANGUAGE] ))
        , [GROUP_ID] = ltrim(rtrim( [GROUP_ID] ))
        , [TITLE] = ltrim(rtrim( [TITLE] ))
        , [URL] = ltrim(rtrim( [URL] ))
        , [SGROUP] = ltrim(rtrim( [SGROUP] ))
    go
--use no_need_to_setup_or_change
go
--create schema ['etlt032']

    --use no_need_to_setup_or_change
    go

    if not exists (select schema_name from information_schema.schemata where schema_name = 'etlt032' ) 
    begin
        exec sp_executesql N'create schema etlt032'
    end
    


    update [etlt032].[load__rc_rd_fe_vega_1498044600] 
      set [DT_FNAME|COMPANY] = ltrim(rtrim( [DT_FNAME|COMPANY] ))
        , [THREAT] = ltrim(rtrim( [THREAT] ))
        , [INTENSITY] = ltrim(rtrim( [INTENSITY] ))
        , [ABS_COUNT] = ltrim(rtrim( [ABS_COUNT] ))
        , [PARENT_THREAT] = ltrim(rtrim( [PARENT_THREAT] ))
    go
--use no_need_to_setup_or_change
go
--create schema ['etlt032']

    --use no_need_to_setup_or_change
    go

    if not exists (select schema_name from information_schema.schemata where schema_name = 'etlt032' ) 
    begin
        exec sp_executesql N'create schema etlt032'
    end
    


    update [etlt032].[load__rc_rd_fe_vega_document_1498044600] 
      set [DT_FNAME|DOCUMENT_ID] = ltrim(rtrim( [DT_FNAME|DOCUMENT_ID] ))
        , [COMPANY] = ltrim(rtrim( [COMPANY] ))
        , [THREAT] = ltrim(rtrim( [THREAT] ))
    go
