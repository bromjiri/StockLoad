

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
if object_id('[etlt032].staging_sftp217_customer', 'U') is not null 
   drop table [etlt032].staging_sftp217_customer
go

go
select * into [etlt032].staging_sftp217_customer
  from ( 
    select

[DT_FNAME] as [DT_FNAME]
,[DT_EOL] as [DT_EOL]
,[ID] as [ID]
,[ShopID] as [ShopID]
,[FirstName] as [FirstName]
,[LastName] as [LastName]
,[Email] as [Email]
,[PPPLevel] as [PPPLevel]
,cast(replace(replace([FeedoPoints], ' ', ''), 0xA0, '') as bigint) as [FeedoPoints]
,cast(replace(replace([PremiumPoints], ' ', ''), 0xA0, '') as bigint) as [PremiumPoints]
,[IsPPPMember] as [IsPPPMember]
,[IsFeedoClubMember] as [IsFeedoClubMember]
,convert(datetime2(0), [RegisteredAt], 104) as [RegisteredAt]
,[NewsletterSubscription] as [NewsletterSubscription]
,[DT_LOAD_ID] as [DT_LOAD_ID]
,[DT_LOAD_SOURCE_PATH] as [DT_LOAD_SOURCE_PATH]
,[DT_LOAD_SOURCE_FILE] as [DT_LOAD_SOURCE_FILE]


	from [etlt032].[load__rc_rd_fe_customer]

union all

select

[DT_FNAME] as [DT_FNAME]
,[DT_EOL] as [DT_EOL]
,[ID] as [ID]
,[ShopID] as [ShopID]
,[FirstName] as [FirstName]
,[LastName] as [LastName]
,[Email] as [Email]
,[PPPLevel] as [PPPLevel]
,cast(replace(replace([FeedoPoints], ' ', ''), 0xA0, '') as bigint) as [FeedoPoints]
,cast(replace(replace([PremiumPoints], ' ', ''), 0xA0, '') as bigint) as [PremiumPoints]
,[IsPPPMember] as [IsPPPMember]
,[IsFeedoClubMember] as [IsFeedoClubMember]
,convert(datetime2(0), [RegisteredAt], 104) as [RegisteredAt]
,[NewsletterSubscription] as [NewsletterSubscription]
,[DT_LOAD_ID] as [DT_LOAD_ID]
,[DT_LOAD_SOURCE_PATH] as [DT_LOAD_SOURCE_PATH]
,[DT_LOAD_SOURCE_FILE] as [DT_LOAD_SOURCE_FILE]

from [etlt032].[load__rc_rd_err_fe_customer_fixed]

    ) x
go


--select * from [etlt032].[load__rc_rd_fe_customer] where  [ID] = 173993;
update a set LastName = 'Ivanova' from [etlt032].[load__rc_rd_fe_customer] a where  [ID] = 173993 and Email = 'ivanovamichaela@seznam.cz';
