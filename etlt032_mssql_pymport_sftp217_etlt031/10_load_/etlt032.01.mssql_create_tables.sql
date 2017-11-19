--use no_need_to_setup_or_change
go
--create schema ['etlt032']

    --use no_need_to_setup_or_change
    go

    if not exists (select schema_name from information_schema.schemata where schema_name = 'etlt032' ) 
    begin
        exec sp_executesql N'create schema etlt032'
    end
    
    if  object_id('etlt032.load__rc_rd_fe_document_1498044600', 'U') is not null 
        drop table [etlt032].[load__rc_rd_fe_document_1498044600];


    create table [etlt032].[load__rc_rd_fe_document_1498044600] (
          [DT_FNAME|DOCUMENT_ID] nvarchar(4000) default ''
        , [TIME] nvarchar(4000) default ''
        , [LANGUAGE] nvarchar(4000) default ''
        , [GROUP_ID] nvarchar(4000) default ''
        , [TITLE] nvarchar(4000) default ''
        , [URL] nvarchar(4000) default ''
        , [SGROUP] nvarchar(4000) default ''
        ) on [primary]
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
    
    if  object_id('etlt032.load__rc_rd_fe_vega_1498044600', 'U') is not null 
        drop table [etlt032].[load__rc_rd_fe_vega_1498044600];


    create table [etlt032].[load__rc_rd_fe_vega_1498044600] (
          [DT_FNAME|COMPANY] nvarchar(4000) default ''
        , [THREAT] nvarchar(4000) default ''
        , [INTENSITY] nvarchar(4000) default ''
        , [ABS_COUNT] nvarchar(4000) default ''
        , [PARENT_THREAT] nvarchar(4000) default ''
        ) on [primary]
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
    
    if  object_id('etlt032.load__rc_rd_fe_vega_document_1498044600', 'U') is not null 
        drop table [etlt032].[load__rc_rd_fe_vega_document_1498044600];


    create table [etlt032].[load__rc_rd_fe_vega_document_1498044600] (
          [DT_FNAME|DOCUMENT_ID] nvarchar(4000) default ''
        , [COMPANY] nvarchar(4000) default ''
        , [THREAT] nvarchar(4000) default ''
        ) on [primary]
    go
