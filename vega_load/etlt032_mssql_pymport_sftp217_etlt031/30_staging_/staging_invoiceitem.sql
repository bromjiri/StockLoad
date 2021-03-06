

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
if object_id('[etlt032].staging_sftp217_invoiceitem', 'U') is not null 
   drop table [etlt032].staging_sftp217_invoiceitem
go

go
select * into [etlt032].staging_sftp217_invoiceitem
  from ( 
    select

     dl.[ID] as [ID]
	,dl.[invoiceID] as [invoiceID]
	,dl.[Deleted] as [Deleted]
	,convert(datetime2(0), dl.[ModifyDate], 104) as [ModifyDate]
	,CASE WHEN (len(dl.[VATRate]) - len(replace(dl.[VATRate], ',', ''))) > 1 OR (charindex(',',dl.[VATRate]) <> 0 AND charindex('.',dl.[VATRate]) <> 0 AND charindex('.',dl.[VATRate]) > charindex(',',dl.[VATRate]))    THEN cast('DT STAGING DATA TYPE ERROR: multiple decimal point.' as int)    ELSE cast(replace(replace(replace(replace(dl.[VATRate], '.', ''), ' ', ''), 0xA0, ''),',','.') as decimal(35, 14)) END as [VATRate]
	,CASE WHEN (len(dl.[PriceExclVAT]) - len(replace(dl.[PriceExclVAT], ',', ''))) > 1 OR (charindex(',',dl.[PriceExclVAT]) <> 0 AND charindex('.',dl.[PriceExclVAT]) <> 0 AND charindex('.',dl.[PriceExclVAT]) > charindex(',',dl.[PriceExclVAT]))    THEN cast('DT STAGING DATA TYPE ERROR: multiple decimal point.' as int)    ELSE cast(replace(replace(replace(replace(dl.[PriceExclVAT], '.', ''), ' ', ''), 0xA0, ''),',','.') as decimal(35, 14)) END as [PriceExclVAT]
	,CASE WHEN (len(dl.[Quantity]) - len(replace(dl.[Quantity], ',', ''))) > 1 OR (charindex(',',dl.[Quantity]) <> 0 AND charindex('.',dl.[Quantity]) <> 0 AND charindex('.',dl.[Quantity]) > charindex(',',dl.[Quantity]))    THEN cast('DT STAGING DATA TYPE ERROR: multiple decimal point.' as int)    ELSE cast(replace(replace(replace(replace(dl.[Quantity], '.', ''), ' ', ''), 0xA0, ''),',','.') as decimal(35, 14)) END as [Quantity]
	,dl.[Name] as [Name]
	,dl.[IsDiscount] as [IsDiscount]
	,dl.[ArtiklID] as [ArtiklID]
	,dl.[ArtiklCode] as [ArtiklCode]
	,dl.[DT_LOAD_ID] as [DT_LOAD_ID]
	,dl.[DT_LOAD_SOURCE_PATH] as [DT_LOAD_SOURCE_PATH]
	,dl.[DT_LOAD_SOURCE_FILE] as [DT_LOAD_SOURCE_FILE]
	,dl.[DT_FNAME] as [DT_FNAME]
	,case when st.ID is not null then 'DAILY' else '' end as [DT_STATIC_DUPLICITY]



	from [etlt032].[load__rc_rd_fe_invoiceitem] dl
	left join [etlt049].[load__rc_rd_fe_static_invoiceitem] st on st.ID = dl.ID

	union all

	select

     st.[ID] as [ID]
	,st.[invoiceID] as [invoiceID]
	,st.[Deleted] as [Deleted]
	,convert(datetime2(0), st.[ModifyDate], 104) as [ModifyDate]
	,CASE WHEN (len(st.[VATRate]) - len(replace(st.[VATRate], ',', ''))) > 1 OR (charindex(',',st.[VATRate]) <> 0 AND charindex('.',st.[VATRate]) <> 0 AND charindex('.',st.[VATRate]) > charindex(',',st.[VATRate]))    THEN cast('DT STAGING DATA TYPE ERROR: multiple decimal point.' as int)    ELSE cast(replace(replace(replace(replace(st.[VATRate], '.', ''), ' ', ''), 0xA0, ''),',','.') as decimal(35, 14)) END as [VATRate]
	,CASE WHEN (len(st.[PriceExclVAT]) - len(replace(st.[PriceExclVAT], ',', ''))) > 1 OR (charindex(',',st.[PriceExclVAT]) <> 0 AND charindex('.',st.[PriceExclVAT]) <> 0 AND charindex('.',st.[PriceExclVAT]) > charindex(',',st.[PriceExclVAT]))    THEN cast('DT STAGING DATA TYPE ERROR: multiple decimal point.' as int)    ELSE cast(replace(replace(replace(replace(st.[PriceExclVAT], '.', ''), ' ', ''), 0xA0, ''),',','.') as decimal(35, 14)) END as [PriceExclVAT]
	,CASE WHEN (len(st.[Quantity]) - len(replace(st.[Quantity], ',', ''))) > 1 OR (charindex(',',st.[Quantity]) <> 0 AND charindex('.',st.[Quantity]) <> 0 AND charindex('.',st.[Quantity]) > charindex(',',st.[Quantity]))    THEN cast('DT STAGING DATA TYPE ERROR: multiple decimal point.' as int)    ELSE cast(replace(replace(replace(replace(st.[Quantity], '.', ''), ' ', ''), 0xA0, ''),',','.') as decimal(35, 14)) END as [Quantity]
	,st.[Name] as [Name]
	,st.[IsDiscount] as [IsDiscount]
	,st.[ArtiklID] as [ArtiklID]
	,st.[ArtiklCode] as [ArtiklCode]
	,st.[DT_LOAD_ID] as [DT_LOAD_ID]
	,st.[DT_LOAD_SOURCE_PATH] as [DT_LOAD_SOURCE_PATH]
	,st.[DT_LOAD_SOURCE_FILE] as [DT_LOAD_SOURCE_FILE]
	,st.[DT_FNAME] as [DT_FNAME]
	,case when dl.ID is not null then 'STATIC' else '' end as [DT_STATIC_DUPLICITY]




	from [etlt049].[load__rc_rd_fe_static_invoiceitem] st
	left join [etlt032].[load__rc_rd_fe_invoiceitem] dl on st.ID = dl.ID
) x
go
