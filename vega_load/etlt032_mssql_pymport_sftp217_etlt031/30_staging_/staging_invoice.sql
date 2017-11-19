

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
if object_id('[etlt032].staging_sftp217_invoice', 'U') is not null 
   drop table [etlt032].staging_sftp217_invoice
go

go
select * into [etlt032].staging_sftp217_invoice
  from ( 
    select

     dl.[ID] as [ID]
    ,dl.[TransactionID] as [TransactionID]
    ,convert(datetime2(0), dl.[CreatedDate], 104) as [CreatedDate]
    ,convert(datetime2(0), dl.[ModifyDate], 104) as [ModifyDate]
    ,dl.[Deleted] as [Deleted]
    ,dl.[No] as [No]
    ,dl.[Currency] as [Currency]
    ,dl.[Name] as [Name]
    ,dl.[Market] as [Market]
    ,cast(replace(replace(dl.[ItemsCount], ' ', ''), 0xA0, '') as bigint) as [ItemsCount]
    ,CASE WHEN (len(dl.[SumInclVAT]) - len(replace(dl.[SumInclVAT], ',', ''))) > 1 OR (charindex(',',dl.[SumInclVAT]) <> 0 AND charindex('.',dl.[SumInclVAT]) <> 0 AND charindex('.',dl.[SumInclVAT]) > charindex(',',dl.[SumInclVAT]))    THEN cast('DT STAGING DATA TYPE ERROR: multiple decimal point.' as int)    ELSE cast(replace(replace(replace(replace(dl.[SumInclVAT], '.', ''), ' ', ''), 0xA0, ''),',','.') as decimal(35, 2)) END as [SumInclVAT]
    ,CASE WHEN (len(dl.[SumExclVAT]) - len(replace(dl.[SumExclVAT], ',', ''))) > 1 OR (charindex(',',dl.[SumExclVAT]) <> 0 AND charindex('.',dl.[SumExclVAT]) <> 0 AND charindex('.',dl.[SumExclVAT]) > charindex(',',dl.[SumExclVAT]))    THEN cast('DT STAGING DATA TYPE ERROR: multiple decimal point.' as int)    ELSE cast(replace(replace(replace(replace(dl.[SumExclVAT], '.', ''), ' ', ''), 0xA0, ''),',','.') as decimal(35, 2)) END as [SumExclVAT]
    ,CASE WHEN (len(dl.[SumVATOnly]) - len(replace(dl.[SumVATOnly], ',', ''))) > 1 OR (charindex(',',dl.[SumVATOnly]) <> 0 AND charindex('.',dl.[SumVATOnly]) <> 0 AND charindex('.',dl.[SumVATOnly]) > charindex(',',dl.[SumVATOnly]))    THEN cast('DT STAGING DATA TYPE ERROR: multiple decimal point.' as int)    ELSE cast(replace(replace(replace(replace(dl.[SumVATOnly], '.', ''), ' ', ''), 0xA0, ''),',','.') as decimal(35, 2)) END as [SumVATOnly]
    ,CASE WHEN (len(dl.[SumInclVATCm]) - len(replace(dl.[SumInclVATCm], ',', ''))) > 1 OR (charindex(',',dl.[SumInclVATCm]) <> 0 AND charindex('.',dl.[SumInclVATCm]) <> 0 AND charindex('.',dl.[SumInclVATCm]) > charindex(',',dl.[SumInclVATCm]))    THEN cast('DT STAGING DATA TYPE ERROR: multiple decimal point.' as int)    ELSE cast(replace(replace(replace(replace(dl.[SumInclVATCm], '.', ''), ' ', ''), 0xA0, ''),',','.') as decimal(35, 2)) END as [SumInclVATCm]
    ,CASE WHEN (len(dl.[SumExclVATCm]) - len(replace(dl.[SumExclVATCm], ',', ''))) > 1 OR (charindex(',',dl.[SumExclVATCm]) <> 0 AND charindex('.',dl.[SumExclVATCm]) <> 0 AND charindex('.',dl.[SumExclVATCm]) > charindex(',',dl.[SumExclVATCm]))    THEN cast('DT STAGING DATA TYPE ERROR: multiple decimal point.' as int)    ELSE cast(replace(replace(replace(replace(dl.[SumExclVATCm], '.', ''), ' ', ''), 0xA0, ''),',','.') as decimal(35, 2)) END as [SumExclVATCm]
    ,CASE WHEN (len(dl.[SumVATOnlyCm]) - len(replace(dl.[SumVATOnlyCm], ',', ''))) > 1 OR (charindex(',',dl.[SumVATOnlyCm]) <> 0 AND charindex('.',dl.[SumVATOnlyCm]) <> 0 AND charindex('.',dl.[SumVATOnlyCm]) > charindex(',',dl.[SumVATOnlyCm]))    THEN cast('DT STAGING DATA TYPE ERROR: multiple decimal point.' as int)    ELSE cast(replace(replace(replace(replace(dl.[SumVATOnlyCm], '.', ''), ' ', ''), 0xA0, ''),',','.') as decimal(35, 2)) END as [SumVATOnlyCm]
    ,CASE WHEN (len(dl.[InvoiceDiscount]) - len(replace(dl.[InvoiceDiscount], ',', ''))) > 1 OR (charindex(',',dl.[InvoiceDiscount]) <> 0 AND charindex('.',dl.[InvoiceDiscount]) <> 0 AND charindex('.',dl.[InvoiceDiscount]) > charindex(',',dl.[InvoiceDiscount]))    THEN cast('DT STAGING DATA TYPE ERROR: multiple decimal point.' as int)    ELSE cast(replace(replace(replace(replace(dl.[InvoiceDiscount], '.', ''), ' ', ''), 0xA0, ''),',','.') as decimal(35, 2)) END as [InvoiceDiscount]
	,CASE WHEN (len(dl.[SumInclVATRegular]) - len(replace(dl.[SumInclVATRegular], ',', ''))) > 1 OR (charindex(',',dl.[SumVATOnlyCm]) <> 0 AND charindex('.',dl.[SumInclVATRegular]) <> 0 AND charindex('.',dl.[SumInclVATRegular]) > charindex(',',dl.[SumInclVATRegular]))    THEN cast('DT STAGING DATA TYPE ERROR: multiple decimal point.' as int)    ELSE cast(replace(replace(replace(replace(dl.[SumInclVATRegular], '.', ''), ' ', ''), 0xA0, ''),',','.') as decimal(35, 2)) END as [SumInclVATRegular]
    ,dl.[DT_LOAD_ID] as [DT_LOAD_ID]
    ,dl.[DT_LOAD_SOURCE_PATH] as [DT_LOAD_SOURCE_PATH]
    ,dl.[DT_LOAD_SOURCE_FILE] as [DT_LOAD_SOURCE_FILE]
    ,dl.[DT_FNAME] as [DT_FNAME]
	,case when st.ID is not null then 'DAILY' else '' end as [DT_STATIC_DUPLICITY]

	from [etlt032].[load__rc_rd_fe_invoice] dl
	left join [etlt049].[load__rc_rd_fe_static_invoice] st on st.ID = dl.ID


	union all

    select

     dl.[ID] as [ID]
    ,dl.[TransactionID] as [TransactionID]
    ,convert(datetime2(0), dl.[CreatedDate], 104) as [CreatedDate]
    ,convert(datetime2(0), dl.[ModifyDate], 104) as [ModifyDate]
    ,dl.[Deleted] as [Deleted]
    ,dl.[No] as [No]
    ,dl.[Currency] as [Currency]
    ,dl.[Name] as [Name]
    ,dl.[Market] as [Market]
    ,cast(replace(replace(dl.[ItemsCount], ' ', ''), 0xA0, '') as bigint) as [ItemsCount]
    ,CASE WHEN (len(dl.[SumInclVAT]) - len(replace(dl.[SumInclVAT], ',', ''))) > 1 OR (charindex(',',dl.[SumInclVAT]) <> 0 AND charindex('.',dl.[SumInclVAT]) <> 0 AND charindex('.',dl.[SumInclVAT]) > charindex(',',dl.[SumInclVAT]))    THEN cast('DT STAGING DATA TYPE ERROR: multiple decimal point.' as int)    ELSE cast(replace(replace(replace(replace(dl.[SumInclVAT], '.', ''), ' ', ''), 0xA0, ''),',','.') as decimal(35, 2)) END as [SumInclVAT]
    ,CASE WHEN (len(dl.[SumExclVAT]) - len(replace(dl.[SumExclVAT], ',', ''))) > 1 OR (charindex(',',dl.[SumExclVAT]) <> 0 AND charindex('.',dl.[SumExclVAT]) <> 0 AND charindex('.',dl.[SumExclVAT]) > charindex(',',dl.[SumExclVAT]))    THEN cast('DT STAGING DATA TYPE ERROR: multiple decimal point.' as int)    ELSE cast(replace(replace(replace(replace(dl.[SumExclVAT], '.', ''), ' ', ''), 0xA0, ''),',','.') as decimal(35, 2)) END as [SumExclVAT]
    ,CASE WHEN (len(dl.[SumVATOnly]) - len(replace(dl.[SumVATOnly], ',', ''))) > 1 OR (charindex(',',dl.[SumVATOnly]) <> 0 AND charindex('.',dl.[SumVATOnly]) <> 0 AND charindex('.',dl.[SumVATOnly]) > charindex(',',dl.[SumVATOnly]))    THEN cast('DT STAGING DATA TYPE ERROR: multiple decimal point.' as int)    ELSE cast(replace(replace(replace(replace(dl.[SumVATOnly], '.', ''), ' ', ''), 0xA0, ''),',','.') as decimal(35, 2)) END as [SumVATOnly]
    ,CASE WHEN (len(dl.[SumInclVATCm]) - len(replace(dl.[SumInclVATCm], ',', ''))) > 1 OR (charindex(',',dl.[SumInclVATCm]) <> 0 AND charindex('.',dl.[SumInclVATCm]) <> 0 AND charindex('.',dl.[SumInclVATCm]) > charindex(',',dl.[SumInclVATCm]))    THEN cast('DT STAGING DATA TYPE ERROR: multiple decimal point.' as int)    ELSE cast(replace(replace(replace(replace(dl.[SumInclVATCm], '.', ''), ' ', ''), 0xA0, ''),',','.') as decimal(35, 2)) END as [SumInclVATCm]
    ,CASE WHEN (len(dl.[SumExclVATCm]) - len(replace(dl.[SumExclVATCm], ',', ''))) > 1 OR (charindex(',',dl.[SumExclVATCm]) <> 0 AND charindex('.',dl.[SumExclVATCm]) <> 0 AND charindex('.',dl.[SumExclVATCm]) > charindex(',',dl.[SumExclVATCm]))    THEN cast('DT STAGING DATA TYPE ERROR: multiple decimal point.' as int)    ELSE cast(replace(replace(replace(replace(dl.[SumExclVATCm], '.', ''), ' ', ''), 0xA0, ''),',','.') as decimal(35, 2)) END as [SumExclVATCm]
    ,CASE WHEN (len(dl.[SumVATOnlyCm]) - len(replace(dl.[SumVATOnlyCm], ',', ''))) > 1 OR (charindex(',',dl.[SumVATOnlyCm]) <> 0 AND charindex('.',dl.[SumVATOnlyCm]) <> 0 AND charindex('.',dl.[SumVATOnlyCm]) > charindex(',',dl.[SumVATOnlyCm]))    THEN cast('DT STAGING DATA TYPE ERROR: multiple decimal point.' as int)    ELSE cast(replace(replace(replace(replace(dl.[SumVATOnlyCm], '.', ''), ' ', ''), 0xA0, ''),',','.') as decimal(35, 2)) END as [SumVATOnlyCm]
    ,CASE WHEN (len(dl.[InvoiceDiscount]) - len(replace(dl.[InvoiceDiscount], ',', ''))) > 1 OR (charindex(',',dl.[InvoiceDiscount]) <> 0 AND charindex('.',dl.[InvoiceDiscount]) <> 0 AND charindex('.',dl.[InvoiceDiscount]) > charindex(',',dl.[InvoiceDiscount]))    THEN cast('DT STAGING DATA TYPE ERROR: multiple decimal point.' as int)    ELSE cast(replace(replace(replace(replace(dl.[InvoiceDiscount], '.', ''), ' ', ''), 0xA0, ''),',','.') as decimal(35, 2)) END as [InvoiceDiscount]
	,CASE WHEN (len(dl.[SumInclVATRegular]) - len(replace(dl.[SumInclVATRegular], ',', ''))) > 1 OR (charindex(',',dl.[SumVATOnlyCm]) <> 0 AND charindex('.',dl.[SumInclVATRegular]) <> 0 AND charindex('.',dl.[SumInclVATRegular]) > charindex(',',dl.[SumInclVATRegular]))    THEN cast('DT STAGING DATA TYPE ERROR: multiple decimal point.' as int)    ELSE cast(replace(replace(replace(replace(dl.[SumInclVATRegular], '.', ''), ' ', ''), 0xA0, ''),',','.') as decimal(35, 2)) END as [SumInclVATRegular]
    ,dl.[DT_LOAD_ID] as [DT_LOAD_ID]
    ,dl.[DT_LOAD_SOURCE_PATH] as [DT_LOAD_SOURCE_PATH]
    ,dl.[DT_LOAD_SOURCE_FILE] as [DT_LOAD_SOURCE_FILE]
    ,dl.[DT_FNAME] as [DT_FNAME]
	,case when st.ID is not null then 'DAILY' else '' end as [DT_STATIC_DUPLICITY]

	from [etlt032].[load__rc_rd_err_fe_invoice_fixed] dl
	left join [etlt049].[load__rc_rd_fe_static_invoice] st on st.ID = dl.ID


	union all


	select

     st.[ID] as [ID]
    ,st.[TransactionID] as [TransactionID]
    ,convert(datetime2(0), st.[CreatedDate], 104) as [CreatedDate]
    ,convert(datetime2(0), st.[ModifyDate], 104) as [ModifyDate]
    ,st.[Deleted] as [Deleted]
    ,st.[No] as [No]
    ,st.[Currency] as [Currency]
    ,st.[Name] as [Name]
    ,st.[Market] as [Market]
    ,cast(replace(replace(st.[ItemsCount], ' ', ''), 0xA0, '') as bigint) as [ItemsCount]
    ,CASE WHEN (len(st.[SumInclVAT]) - len(replace(st.[SumInclVAT], ',', ''))) > 1 OR (charindex(',',st.[SumInclVAT]) <> 0 AND charindex('.',st.[SumInclVAT]) <> 0 AND charindex('.',st.[SumInclVAT]) > charindex(',',st.[SumInclVAT]))    THEN cast('DT STAGING DATA TYPE ERROR: multiple decimal point.' as int)    ELSE cast(replace(replace(replace(replace(st.[SumInclVAT], '.', ''), ' ', ''), 0xA0, ''),',','.') as decimal(35, 2)) END as [SumInclVAT]
    ,CASE WHEN (len(st.[SumExclVAT]) - len(replace(st.[SumExclVAT], ',', ''))) > 1 OR (charindex(',',st.[SumExclVAT]) <> 0 AND charindex('.',st.[SumExclVAT]) <> 0 AND charindex('.',st.[SumExclVAT]) > charindex(',',st.[SumExclVAT]))    THEN cast('DT STAGING DATA TYPE ERROR: multiple decimal point.' as int)    ELSE cast(replace(replace(replace(replace(st.[SumExclVAT], '.', ''), ' ', ''), 0xA0, ''),',','.') as decimal(35, 2)) END as [SumExclVAT]
    ,CASE WHEN (len(st.[SumVATOnly]) - len(replace(st.[SumVATOnly], ',', ''))) > 1 OR (charindex(',',st.[SumVATOnly]) <> 0 AND charindex('.',st.[SumVATOnly]) <> 0 AND charindex('.',st.[SumVATOnly]) > charindex(',',st.[SumVATOnly]))    THEN cast('DT STAGING DATA TYPE ERROR: multiple decimal point.' as int)    ELSE cast(replace(replace(replace(replace(st.[SumVATOnly], '.', ''), ' ', ''), 0xA0, ''),',','.') as decimal(35, 2)) END as [SumVATOnly]
    ,CASE WHEN (len(st.[SumInclVATCm]) - len(replace(st.[SumInclVATCm], ',', ''))) > 1 OR (charindex(',',st.[SumInclVATCm]) <> 0 AND charindex('.',st.[SumInclVATCm]) <> 0 AND charindex('.',st.[SumInclVATCm]) > charindex(',',st.[SumInclVATCm]))    THEN cast('DT STAGING DATA TYPE ERROR: multiple decimal point.' as int)    ELSE cast(replace(replace(replace(replace(st.[SumInclVATCm], '.', ''), ' ', ''), 0xA0, ''),',','.') as decimal(35, 2)) END as [SumInclVATCm]
    ,CASE WHEN (len(st.[SumExclVATCm]) - len(replace(st.[SumExclVATCm], ',', ''))) > 1 OR (charindex(',',st.[SumExclVATCm]) <> 0 AND charindex('.',st.[SumExclVATCm]) <> 0 AND charindex('.',st.[SumExclVATCm]) > charindex(',',st.[SumExclVATCm]))    THEN cast('DT STAGING DATA TYPE ERROR: multiple decimal point.' as int)    ELSE cast(replace(replace(replace(replace(st.[SumExclVATCm], '.', ''), ' ', ''), 0xA0, ''),',','.') as decimal(35, 2)) END as [SumExclVATCm]
    ,CASE WHEN (len(st.[SumVATOnlyCm]) - len(replace(st.[SumVATOnlyCm], ',', ''))) > 1 OR (charindex(',',st.[SumVATOnlyCm]) <> 0 AND charindex('.',st.[SumVATOnlyCm]) <> 0 AND charindex('.',st.[SumVATOnlyCm]) > charindex(',',st.[SumVATOnlyCm]))    THEN cast('DT STAGING DATA TYPE ERROR: multiple decimal point.' as int)    ELSE cast(replace(replace(replace(replace(st.[SumVATOnlyCm], '.', ''), ' ', ''), 0xA0, ''),',','.') as decimal(35, 2)) END as [SumVATOnlyCm]
    ,CASE WHEN (len(st.[InvoiceDiscount]) - len(replace(st.[InvoiceDiscount], ',', ''))) > 1 OR (charindex(',',st.[InvoiceDiscount]) <> 0 AND charindex('.',st.[InvoiceDiscount]) <> 0 AND charindex('.',st.[InvoiceDiscount]) > charindex(',',st.[InvoiceDiscount]))    THEN cast('DT STAGING DATA TYPE ERROR: multiple decimal point.' as int)    ELSE cast(replace(replace(replace(replace(st.[InvoiceDiscount], '.', ''), ' ', ''), 0xA0, ''),',','.') as decimal(35, 2)) END as [InvoiceDiscount]
	,CASE WHEN (len(st.[SumInclVATRegular]) - len(replace(st.[SumInclVATRegular], ',', ''))) > 1 OR (charindex(',',st.[SumVATOnlyCm]) <> 0 AND charindex('.',st.[SumInclVATRegular]) <> 0 AND charindex('.',st.[SumInclVATRegular]) > charindex(',',st.[SumInclVATRegular]))    THEN cast('DT STAGING DATA TYPE ERROR: multiple decimal point.' as int)    ELSE cast(replace(replace(replace(replace(st.[SumInclVATRegular], '.', ''), ' ', ''), 0xA0, ''),',','.') as decimal(35, 2)) END as [SumInclVATRegular]
    ,st.[DT_LOAD_ID] as [DT_LOAD_ID]
    ,st.[DT_LOAD_SOURCE_PATH] as [DT_LOAD_SOURCE_PATH]
    ,st.[DT_LOAD_SOURCE_FILE] as [DT_LOAD_SOURCE_FILE]
    ,st.[DT_FNAME] as [DT_FNAME]
	,case when dl.ID is not null then 'STATIC' else '' end as [DT_STATIC_DUPLICITY]

	from [etlt049].[load__rc_rd_fe_static_invoice] st
	left join [etlt032].[load__rc_rd_fe_invoice] dl on st.ID = dl.ID

	union all


	select

     st.[ID] as [ID]
    ,st.[TransactionID] as [TransactionID]
    ,convert(datetime2(0), st.[CreatedDate], 104) as [CreatedDate]
    ,convert(datetime2(0), st.[ModifyDate], 104) as [ModifyDate]
    ,st.[Deleted] as [Deleted]
    ,st.[No] as [No]
    ,st.[Currency] as [Currency]
    ,st.[Name] as [Name]
    ,st.[Market] as [Market]
    ,cast(replace(replace(st.[ItemsCount], ' ', ''), 0xA0, '') as bigint) as [ItemsCount]
    ,CASE WHEN (len(st.[SumInclVAT]) - len(replace(st.[SumInclVAT], ',', ''))) > 1 OR (charindex(',',st.[SumInclVAT]) <> 0 AND charindex('.',st.[SumInclVAT]) <> 0 AND charindex('.',st.[SumInclVAT]) > charindex(',',st.[SumInclVAT]))    THEN cast('DT STAGING DATA TYPE ERROR: multiple decimal point.' as int)    ELSE cast(replace(replace(replace(replace(st.[SumInclVAT], '.', ''), ' ', ''), 0xA0, ''),',','.') as decimal(35, 2)) END as [SumInclVAT]
    ,CASE WHEN (len(st.[SumExclVAT]) - len(replace(st.[SumExclVAT], ',', ''))) > 1 OR (charindex(',',st.[SumExclVAT]) <> 0 AND charindex('.',st.[SumExclVAT]) <> 0 AND charindex('.',st.[SumExclVAT]) > charindex(',',st.[SumExclVAT]))    THEN cast('DT STAGING DATA TYPE ERROR: multiple decimal point.' as int)    ELSE cast(replace(replace(replace(replace(st.[SumExclVAT], '.', ''), ' ', ''), 0xA0, ''),',','.') as decimal(35, 2)) END as [SumExclVAT]
    ,CASE WHEN (len(st.[SumVATOnly]) - len(replace(st.[SumVATOnly], ',', ''))) > 1 OR (charindex(',',st.[SumVATOnly]) <> 0 AND charindex('.',st.[SumVATOnly]) <> 0 AND charindex('.',st.[SumVATOnly]) > charindex(',',st.[SumVATOnly]))    THEN cast('DT STAGING DATA TYPE ERROR: multiple decimal point.' as int)    ELSE cast(replace(replace(replace(replace(st.[SumVATOnly], '.', ''), ' ', ''), 0xA0, ''),',','.') as decimal(35, 2)) END as [SumVATOnly]
    ,CASE WHEN (len(st.[SumInclVATCm]) - len(replace(st.[SumInclVATCm], ',', ''))) > 1 OR (charindex(',',st.[SumInclVATCm]) <> 0 AND charindex('.',st.[SumInclVATCm]) <> 0 AND charindex('.',st.[SumInclVATCm]) > charindex(',',st.[SumInclVATCm]))    THEN cast('DT STAGING DATA TYPE ERROR: multiple decimal point.' as int)    ELSE cast(replace(replace(replace(replace(st.[SumInclVATCm], '.', ''), ' ', ''), 0xA0, ''),',','.') as decimal(35, 2)) END as [SumInclVATCm]
    ,CASE WHEN (len(st.[SumExclVATCm]) - len(replace(st.[SumExclVATCm], ',', ''))) > 1 OR (charindex(',',st.[SumExclVATCm]) <> 0 AND charindex('.',st.[SumExclVATCm]) <> 0 AND charindex('.',st.[SumExclVATCm]) > charindex(',',st.[SumExclVATCm]))    THEN cast('DT STAGING DATA TYPE ERROR: multiple decimal point.' as int)    ELSE cast(replace(replace(replace(replace(st.[SumExclVATCm], '.', ''), ' ', ''), 0xA0, ''),',','.') as decimal(35, 2)) END as [SumExclVATCm]
    ,CASE WHEN (len(st.[SumVATOnlyCm]) - len(replace(st.[SumVATOnlyCm], ',', ''))) > 1 OR (charindex(',',st.[SumVATOnlyCm]) <> 0 AND charindex('.',st.[SumVATOnlyCm]) <> 0 AND charindex('.',st.[SumVATOnlyCm]) > charindex(',',st.[SumVATOnlyCm]))    THEN cast('DT STAGING DATA TYPE ERROR: multiple decimal point.' as int)    ELSE cast(replace(replace(replace(replace(st.[SumVATOnlyCm], '.', ''), ' ', ''), 0xA0, ''),',','.') as decimal(35, 2)) END as [SumVATOnlyCm]
    ,CASE WHEN (len(st.[InvoiceDiscount]) - len(replace(st.[InvoiceDiscount], ',', ''))) > 1 OR (charindex(',',st.[InvoiceDiscount]) <> 0 AND charindex('.',st.[InvoiceDiscount]) <> 0 AND charindex('.',st.[InvoiceDiscount]) > charindex(',',st.[InvoiceDiscount]))    THEN cast('DT STAGING DATA TYPE ERROR: multiple decimal point.' as int)    ELSE cast(replace(replace(replace(replace(st.[InvoiceDiscount], '.', ''), ' ', ''), 0xA0, ''),',','.') as decimal(35, 2)) END as [InvoiceDiscount]
	,CASE WHEN (len(st.[SumInclVATRegular]) - len(replace(st.[SumInclVATRegular], ',', ''))) > 1 OR (charindex(',',st.[SumVATOnlyCm]) <> 0 AND charindex('.',st.[SumInclVATRegular]) <> 0 AND charindex('.',st.[SumInclVATRegular]) > charindex(',',st.[SumInclVATRegular]))    THEN cast('DT STAGING DATA TYPE ERROR: multiple decimal point.' as int)    ELSE cast(replace(replace(replace(replace(st.[SumInclVATRegular], '.', ''), ' ', ''), 0xA0, ''),',','.') as decimal(35, 2)) END as [SumInclVATRegular]
    ,st.[DT_LOAD_ID] as [DT_LOAD_ID]
    ,st.[DT_LOAD_SOURCE_PATH] as [DT_LOAD_SOURCE_PATH]
    ,st.[DT_LOAD_SOURCE_FILE] as [DT_LOAD_SOURCE_FILE]
    ,st.[DT_FNAME] as [DT_FNAME]
	,case when dl.ID is not null then 'STATIC' else '' end as [DT_STATIC_DUPLICITY]

	from [etlt049].[load__rc_rd_fe_static_invoice] st
	left join [etlt032].[load__rc_rd_err_fe_invoice_fixed] dl on st.ID = dl.ID

) x
go
