

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
if object_id('[etlt032].staging_sftp217_stock', 'U') is not null 
   drop table [etlt032].staging_sftp217_stock
go

go
select * into [etlt032].staging_sftp217_stock
  from ( 
    select

     [DT_FNAME] as [DT_FNAME]
    ,[DT_EOL] as [DT_EOL]
    ,[ArtiklID] as [ArtiklID]
    ,CASE WHEN (len([Skladem]) - len(replace([Skladem], ',', ''))) > 1 OR (charindex(',',[Skladem]) <> 0 AND charindex('.',[Skladem]) <> 0 AND charindex('.',[Skladem]) > charindex(',',[Skladem]))    THEN cast('DT STAGING DATA TYPE ERROR: multiple decimal point.' as int)    ELSE cast(replace(replace(replace(replace([Skladem], '.', ''), ' ', ''), 0xA0, ''),',','.') as decimal(35, 4)) END as [Skladem]
    ,CASE WHEN (len([Rezervovano]) - len(replace([Rezervovano], ',', ''))) > 1 OR (charindex(',',[Rezervovano]) <> 0 AND charindex('.',[Rezervovano]) <> 0 AND charindex('.',[Rezervovano]) > charindex(',',[Rezervovano]))    THEN cast('DT STAGING DATA TYPE ERROR: multiple decimal point.' as int)    ELSE cast(replace(replace(replace(replace([Rezervovano], '.', ''), ' ', ''), 0xA0, ''),',','.') as decimal(35, 4)) END as [Rezervovano]
    ,CASE WHEN (len([Objednano]) - len(replace([Objednano], ',', ''))) > 1 OR (charindex(',',[Objednano]) <> 0 AND charindex('.',[Objednano]) <> 0 AND charindex('.',[Objednano]) > charindex(',',[Objednano]))    THEN cast('DT STAGING DATA TYPE ERROR: multiple decimal point.' as int)    ELSE cast(replace(replace(replace(replace([Objednano], '.', ''), ' ', ''), 0xA0, ''),',','.') as decimal(35, 4)) END as [Objednano]
    ,[DT_LOAD_ID] as [DT_LOAD_ID]
    ,[DT_LOAD_SOURCE_PATH] as [DT_LOAD_SOURCE_PATH]
    ,[DT_LOAD_SOURCE_FILE] as [DT_LOAD_SOURCE_FILE]

	from [etlt032].[load__rc_rd_fe_stock]
) x
go
