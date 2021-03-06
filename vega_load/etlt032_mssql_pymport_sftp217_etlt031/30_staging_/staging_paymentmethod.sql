

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
if object_id('[etlt032].staging_sftp217_paymentmethod', 'U') is not null 
   drop table [etlt032].staging_sftp217_paymentmethod
go

go
select * into [etlt032].staging_sftp217_paymentmethod
  from ( 
    select

       [ID] as [ID]
      ,[Name] as [Name]
      ,[DT_LOAD_ID]
      ,[DT_LOAD_SOURCE_PATH]
      ,[DT_LOAD_SOURCE_FILE]
      , [DT_FNAME] as [DT_FNAME]

	from [etlt032].[load__rc_rd_fe_paymentmethod]
) x
go
