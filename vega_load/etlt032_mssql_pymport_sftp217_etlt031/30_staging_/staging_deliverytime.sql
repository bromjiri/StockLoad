

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
if object_id('[etlt032].staging_sftp217_deliverytime', 'U') is not null 
   drop table [etlt032].staging_sftp217_deliverytime
go

go
select * into [etlt032].staging_sftp217_deliverytime
  from ( 
    select

     t1.[ID] as [ID]
    ,t1.[DeliveryNoteID] as [DeliveryNoteID]
    ,t1.[Deleted] as [Deleted]
    ,CASE WHEN (len(t1.[AmountOrdered]) - len(replace(t1.[AmountOrdered], ',', ''))) > 1 OR (charindex(',',t1.[AmountOrdered]) <> 0 AND charindex('.',t1.[AmountOrdered]) <> 0 AND charindex('.',t1.[AmountOrdered]) > charindex(',',t1.[AmountOrdered]))    THEN cast('DT STAGING DATA TYPE ERROR: multiple decimal point.' as int)    ELSE cast(replace(replace(replace(replace(t1.[AmountOrdered], '.', ''), ' ', ''), 0xA0, ''),',','.') as decimal(35, 14)) END as [AmountOrdered]
    ,CASE WHEN (len(t1.[AmountDelivered]) - len(replace(t1.[AmountDelivered], ',', ''))) > 1 OR (charindex(',',t1.[AmountDelivered]) <> 0 AND charindex('.',t1.[AmountDelivered]) <> 0 AND charindex('.',t1.[AmountDelivered]) > charindex(',',t1.[AmountDelivered]))    THEN cast('DT STAGING DATA TYPE ERROR: multiple decimal point.' as int)    ELSE cast(replace(replace(replace(replace(t1.[AmountDelivered], '.', ''), ' ', ''), 0xA0, ''),',','.') as decimal(35, 14)) END as [AmountDelivered]
    ,t1.ItemID as ItemID 
    ,t1.[OrderID] as [OrderID]
    ,convert(datetime2(0), t1.[OrderDate], 104) as [OrderDate]
    ,convert(datetime2(0), t1.[OrderDateFinished], 104) as [OrderDateFinished]
    ,cast(replace(replace(t1.[DeliveryTimeInDays], ' ', ''), 0xA0, '') as bigint) as [DeliveryTimeInDays]
    ,t1.[DT_LOAD_ID] as [DT_LOAD_ID]
    ,t1.[DT_LOAD_SOURCE_PATH] as [DT_LOAD_SOURCE_PATH]
    ,t1.[DT_LOAD_SOURCE_FILE] as [DT_LOAD_SOURCE_FILE]
    ,t1.[DT_FNAME] as [DT_FNAME]
	,case when t2.ID is not null then 'DAILY' else '' end as [DT_STATIC_DUPLICITY]

	from [etlt032].[load__rc_rd_fe_deliverytime] t1
	left join [etlt049].[load__rc_rd_fe_static_deliverytime] t2 on t2.ID = t1.ID


	union all

	select

     t1.[ID] as [ID]
    ,t1.[DeliveryNoteID] as [DeliveryNoteID]
    ,t1.[Deleted] as [Deleted]
    ,CASE WHEN (len(t1.[AmountOrdered]) - len(replace(t1.[AmountOrdered], ',', ''))) > 1 OR (charindex(',',t1.[AmountOrdered]) <> 0 AND charindex('.',t1.[AmountOrdered]) <> 0 AND charindex('.',t1.[AmountOrdered]) > charindex(',',t1.[AmountOrdered]))    THEN cast('DT STAGING DATA TYPE ERROR: multiple decimal point.' as int)    ELSE cast(replace(replace(replace(replace(t1.[AmountOrdered], '.', ''), ' ', ''), 0xA0, ''),',','.') as decimal(35, 14)) END as [AmountOrdered]
    ,CASE WHEN (len(t1.[AmountDelivered]) - len(replace(t1.[AmountDelivered], ',', ''))) > 1 OR (charindex(',',t1.[AmountDelivered]) <> 0 AND charindex('.',t1.[AmountDelivered]) <> 0 AND charindex('.',t1.[AmountDelivered]) > charindex(',',t1.[AmountDelivered]))    THEN cast('DT STAGING DATA TYPE ERROR: multiple decimal point.' as int)    ELSE cast(replace(replace(replace(replace(t1.[AmountDelivered], '.', ''), ' ', ''), 0xA0, ''),',','.') as decimal(35, 14)) END as [AmountDelivered]
    ,t1.[ItemID] as [ItemID]
    ,t1.[OrderID] as [OrderID]
    ,convert(datetime2(0), t1.[OrderDate], 104) as [OrderDate]
    ,convert(datetime2(0), t1.[OrderDateFinished], 104) as [OrderDateFinished]
    ,cast(replace(replace(t1.[DeliveryTimeInDays], ' ', ''), 0xA0, '') as bigint) as [DeliveryTimeInDays]
    ,t1.[DT_LOAD_ID] as [DT_LOAD_ID]
    ,t1.[DT_LOAD_SOURCE_PATH] as [DT_LOAD_SOURCE_PATH]
    ,t1.[DT_LOAD_SOURCE_FILE] as [DT_LOAD_SOURCE_FILE]
    ,t1.[DT_FNAME] as [DT_FNAME]
	,case when t2.ID is not null then 'STATIC' else '' end as [DT_STATIC_DUPLICITY]

	from [etlt049].[load__rc_rd_fe_static_deliverytime] t1
	left join [etlt032].[load__rc_rd_fe_deliverytime] t2 on t2.ID = t1.ID
) x
go
