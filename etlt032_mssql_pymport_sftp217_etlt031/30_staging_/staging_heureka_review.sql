

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
if object_id('[etlt032].staging_sftp217_heurekareview', 'U') is not null 
   drop table [etlt032].staging_sftp217_heurekareview
go

go
select * into [etlt032].staging_sftp217_heurekareview
  from ( 
    select

         [ID] as [ID]
        ,[ShopID] as [ShopID]
        ,[EAN] as [EAN]
        ,convert(datetime2(0), [Date], 104) as [Date]
        ,[Rating] as [Rating]
        ,[OrderID] as [OrderID]
        ,[DT_LOAD_ID] as [DT_LOAD_ID]
        ,[DT_LOAD_SOURCE_PATH] as [DT_LOAD_SOURCE_PATH]
        ,[DT_LOAD_SOURCE_FILE] as [DT_LOAD_SOURCE_FILE]
        ,[DT_FNAME] as [DT_FNAME]

	from [etlt032].[load__rc_rd_fe_heurekareview]
) x
go
