

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
if object_id('[etlt032].staging_sftp217_margin', 'U') is not null 
   drop table [etlt032].staging_sftp217_margin
go

go
select * into [etlt032].staging_sftp217_margin
  from ( 
    select

    [DT_FNAME] as [DT_FNAME]
    ,[DT_EOL] as [DT_EOL]
    ,[ArtiklID] as [ArtiklID]
    ,CASE WHEN (len([SkladovaCena]) - len(replace([SkladovaCena], ',', ''))) > 1 OR (charindex(',',[SkladovaCena]) <> 0 AND charindex('.',[SkladovaCena]) <> 0 AND charindex('.',[SkladovaCena]) > charindex(',',[SkladovaCena]))    THEN cast('DT STAGING DATA TYPE ERROR: multiple decimal point.' as int)    ELSE cast(replace(replace(replace(replace([SkladovaCena], '.', ''), ' ', ''), 0xA0, ''),',','.') as decimal(35, 14)) END as [SkladovaCena]
	,CASE WHEN (len([ProdejniCena]) - len(replace([ProdejniCena], ',', ''))) > 1 OR (charindex(',',[ProdejniCena]) <> 0 AND charindex('.',[ProdejniCena]) <> 0 AND charindex('.',[ProdejniCena]) > charindex(',',[ProdejniCena]))    THEN cast('DT STAGING DATA TYPE ERROR: multiple decimal point.' as int)    ELSE cast(replace(replace(replace(replace([ProdejniCena], '.', ''), ' ', ''), 0xA0, ''),',','.') as decimal(35, 14)) END as [ProdejniCena]
	,CASE WHEN (len([MarginProc]) - len(replace([MarginProc], ',', ''))) > 1 OR (charindex(',',[MarginProc]) <> 0 AND charindex('.',[MarginProc]) <> 0 AND charindex('.',[MarginProc]) > charindex(',',[MarginProc]))    THEN cast('DT STAGING DATA TYPE ERROR: multiple decimal point.' as int)    ELSE cast(replace(replace(replace(replace([MarginProc], '.', ''), ' ', ''), 0xA0, ''),',','.') as decimal(35, 14)) END as [MarginProc]
    ,CASE WHEN (len([BonusProc]) - len(replace([BonusProc], ',', ''))) > 1 OR (charindex(',',[BonusProc]) <> 0 AND charindex('.',[BonusProc]) <> 0 AND charindex('.',[BonusProc]) > charindex(',',[BonusProc]))    THEN cast('DT STAGING DATA TYPE ERROR: multiple decimal point.' as int)    ELSE cast(replace(replace(replace(replace([BonusProc], '.', ''), ' ', ''), 0xA0, ''),',','.') as decimal(35, 14)) END as [BonusProc]
	,convert(datetime2(0), [Date], 104) as [Date]
    ,[DT_LOAD_ID] as [DT_LOAD_ID]
    ,[DT_LOAD_SOURCE_PATH] as [DT_LOAD_SOURCE_PATH]
    ,[DT_LOAD_SOURCE_FILE] as [DT_LOAD_SOURCE_FILE]

	from [etlt032].[load__rc_rd_fe_margin]
) x
go
