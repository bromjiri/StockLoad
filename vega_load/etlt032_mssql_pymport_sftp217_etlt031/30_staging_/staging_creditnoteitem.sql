

--No need to use following line it because script is to be launched by #run_all.cmd
--use [DB]

SET DATEFORMAT 'dmy' --mdy
go

print 'staging start'
go

--DO NOT use following syntax in template, because no ones remembers how to actually fill in things
--if object_id('', 'U') is not null drop table [TARGET]
--and DO NOT delete above note for future generations coming with same idea

--therefore leave following (more helpful and memory refreshing) syntax in template
if object_id('[etlt032].staging_sftp217_creditnoteitem', 'U') is not null 
   drop table [etlt032].staging_sftp217_creditnoteitem
go

go
select * into [etlt032].staging_sftp217_creditnoteitem
  from ( 
    select

     t1.[ArtiklID] as [ArtiklID]
	,t1.[ArtiklCode] as [ArtiklCode]
	,t1.[ID] as [ID]
	,t1.[creditNoteID] as [creditNoteID]
	,t1.[Deleted] as [Deleted]
	,CASE WHEN (len(t1.[VATRate]) - len(replace(t1.[VATRate], ',', ''))) > 1 OR (charindex(',',t1.[VATRate]) <> 0 AND charindex('.',t1.[VATRate]) <> 0 AND charindex('.',t1.[VATRate]) > charindex(',',t1.[VATRate]))    THEN cast('DT STAGING DATA TYPE ERROR: multiple decimal point.' as int)    ELSE cast(replace(replace(replace(replace(t1.[VATRate], '.', ''), ' ', ''), 0xA0, ''),',','.') as decimal(35, 14)) END as [VATRate]
	,CASE WHEN (len(t1.[PriceExclVAT]) - len(replace(t1.[PriceExclVAT], ',', ''))) > 1 OR (charindex(',',t1.[PriceExclVAT]) <> 0 AND charindex('.',t1.[PriceExclVAT]) <> 0 AND charindex('.',t1.[PriceExclVAT]) > charindex(',',t1.[PriceExclVAT]))    THEN cast('DT STAGING DATA TYPE ERROR: multiple decimal point.' as int)    ELSE cast(replace(replace(replace(replace(t1.[PriceExclVAT], '.', ''), ' ', ''), 0xA0, ''),',','.') as decimal(35, 14)) END as [PriceExclVAT]
	,CASE WHEN (len(t1.[Quantity]) - len(replace(t1.[Quantity], ',', ''))) > 1 OR (charindex(',',t1.[Quantity]) <> 0 AND charindex('.',t1.[Quantity]) <> 0 AND charindex('.',t1.[Quantity]) > charindex(',',t1.[Quantity]))    THEN cast('DT STAGING DATA TYPE ERROR: multiple decimal point.' as int)    ELSE cast(replace(replace(replace(replace(t1.[Quantity], '.', ''), ' ', ''), 0xA0, ''),',','.') as decimal(35, 14)) END as [Quantity]
	,t1.[Name] as [Name]
	,t1.[IsDiscount] as [IsDiscount]
	,convert(datetime2(0), t1.[ModifyDate], 104) as [ModifyDate]
	,t1.[DT_LOAD_ID] as [DT_LOAD_ID]
	,t1.[DT_LOAD_SOURCE_PATH] as [DT_LOAD_SOURCE_PATH]
	,t1.[DT_LOAD_SOURCE_FILE] as [DT_LOAD_SOURCE_FILE]
	,t1.[DT_FNAME] as [DT_FNAME]
	,case when t2.ID is not null then 'DAILY' else '' end as [DT_STATIC_DUPLICITY]

	from [etlt032].[load__rc_rd_fe_creditnoteitem] t1
	left join [etlt049].[load__rc_rd_fe_static_creditnoteitem] t2 on t2.ID = t1.ID

	union all

	select

     t1.[ArtiklID] as [ArtiklID]
	,t1.[ArtiklCode] as [ArtiklCode]
	,t1.[ID] as [ID]
	,t1.[creditNoteID] as [creditNoteID]
	,t1.[Deleted] as [Deleted]
	,CASE WHEN (len(t1.[VATRate]) - len(replace(t1.[VATRate], ',', ''))) > 1 OR (charindex(',',t1.[VATRate]) <> 0 AND charindex('.',t1.[VATRate]) <> 0 AND charindex('.',t1.[VATRate]) > charindex(',',t1.[VATRate]))    THEN cast('DT STAGING DATA TYPE ERROR: multiple decimal point.' as int)    ELSE cast(replace(replace(replace(replace(t1.[VATRate], '.', ''), ' ', ''), 0xA0, ''),',','.') as decimal(35, 14)) END as [VATRate]
	,CASE WHEN (len(t1.[PriceExclVAT]) - len(replace(t1.[PriceExclVAT], ',', ''))) > 1 OR (charindex(',',t1.[PriceExclVAT]) <> 0 AND charindex('.',t1.[PriceExclVAT]) <> 0 AND charindex('.',t1.[PriceExclVAT]) > charindex(',',t1.[PriceExclVAT]))    THEN cast('DT STAGING DATA TYPE ERROR: multiple decimal point.' as int)    ELSE cast(replace(replace(replace(replace(t1.[PriceExclVAT], '.', ''), ' ', ''), 0xA0, ''),',','.') as decimal(35, 14)) END as [PriceExclVAT]
	,CASE WHEN (len(t1.[Quantity]) - len(replace(t1.[Quantity], ',', ''))) > 1 OR (charindex(',',t1.[Quantity]) <> 0 AND charindex('.',t1.[Quantity]) <> 0 AND charindex('.',t1.[Quantity]) > charindex(',',t1.[Quantity]))    THEN cast('DT STAGING DATA TYPE ERROR: multiple decimal point.' as int)    ELSE cast(replace(replace(replace(replace(t1.[Quantity], '.', ''), ' ', ''), 0xA0, ''),',','.') as decimal(35, 14)) END as [Quantity]
	,t1.[Name] as [Name]
	,t1.[IsDiscount] as [IsDiscount]
	,convert(datetime2(0), t1.[ModifyDate], 104) as [ModifyDate]
	,t1.[DT_LOAD_ID] as [DT_LOAD_ID]
	,t1.[DT_LOAD_SOURCE_PATH] as [DT_LOAD_SOURCE_PATH]
	,t1.[DT_LOAD_SOURCE_FILE] as [DT_LOAD_SOURCE_FILE]
	,t1.[DT_FNAME] as [DT_FNAME]
	,case when t2.ID is not null then 'STATIC' else '' end as [DT_STATIC_DUPLICITY]

	from [etlt049].[load__rc_rd_fe_static_creditnoteitem] t1
	left join [etlt032].[load__rc_rd_fe_creditnoteitem] t2 on t2.ID = t1.ID
) x
go


