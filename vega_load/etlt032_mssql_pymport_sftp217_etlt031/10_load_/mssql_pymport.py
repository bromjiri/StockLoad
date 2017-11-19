#! /usr/bin/python
# -*- coding: cp1250 -*-

import sys
from etlt032_mssql_pymport_sftp217_etlt031._mssql_pymport_config import *

#print( "This script is going to DELETE all SQL scripts in this directory!!")
#ri = input("Enter 'ok' and Enter if it what you desire. ")
#if ri.lower() != 'ok':
#    print ("Yo pressed:", ri, "Script will end now."); sys.exit()
#else:
#    print ("OK entered, script will continue now.")

############## THERE SHOULD BE NO NEED TO CHANGE ANYTHING BELOW ###############

#from project_toolbox_elephant_hypo import *
import codecs, glob, os, string, re
#import transform as t

cmd = []

#delete all sql files here
for f in glob.glob('*.sql'):
    os.remove(f)

def transform_chars(text):
    # selectively transform french characters in a string
    chs     = "ňěščřžýáíůČŠĚŽŘŮaäeilouáéíóúâeîôuçaoAEIOUÁÉÍÓÚÂEÎÔUÚúAOľť"
    cht     = "nescrzyaiuCSEZRUaaeilouaeiouaeioucaoAEIOUAEIOUAEIOUUuAOlt"

    r = ''
    for c in text:
        if c in chs:
            r += cht[chs.find(c)]
        else:
            r += c
    return r

    
## #    CREATE TABLE(S) ##

def createTableString(inFile, tableName, tableSchema='dbo', colDelimiter=";", hasHeader=0):
    ''' '''
    res = ''
    out_h = {}
    header_l = []
    flcnt_n = 0
    #print inFile
    #for line_s in bt.lines(inFile):
    #sf = open(inFile, 'r')
    sf = codecs.open(inFile, 'r', 'utf-16')
    #sf = codecs.open(inFile, 'r', 'utf-8')
    
    while flcnt_n < 5:
        line_s = sf.readline()
        #line_s = 
        #line_s = line_s.encode('cp1250')
        #line_s = line_s.encode('utf-8')
        flcnt_n += 1
        
        #2011-06-14_1501 vip remove EOLs
        #2016-11-08 1215 jz changed bytes to str
        line_s = re.sub('\x0D\x0A', '', line_s)
        line_s = re.sub('\x0D', '', line_s)
        line_s = re.sub('\x0A', '', line_s)
        
        #columns_l = string.split(line_s[:-1], colDelimiter)
        columns_l = line_s.split( colDelimiter)
        for index, value in enumerate(columns_l):
            index = 'c'+str(index+1).zfill(3)

            if  hasHeader != 0 and flcnt_n == 1:
                #use cXXX form form column names
                header_l = columns_l
                # do nothing except skipping columns span calculation for header row
            elif out_h.get(index):
                if  out_h[index] < len(str(value)):
                    out_h[index] = len(str(value))
            else:
                out_h[index] = len(str(value))

    tbname = tableName
    res += '''
    if  object_id('%s.%s', 'U') is not null 
        drop table [%s].[%s];


    ''' % (tableSchema, tableName, tableSchema, tableName)
    
    #print out_h; print header_l
    res += "create table [%s].[%s] (" % (tableSchema, tableName)
    for i in sorted(out_h.keys()):
        if hasHeader != 0:

            #print header_l
            cheader = header_l[int(i[1:])-1]#.lower()
            #cheader = re.sub('[/,. ]', '_', cheader)

            #print header_l[int(i[1:])-1]
            #print re.search('\d{3}-\d{3}-\d{3}-', header_l[int(i[1:])-1])
            if re.search('\d{3}-\d{3}-\d{3}-', cheader): # ddd_ddd_ddd_...
                cname = 'dt_src_rowid'
            else:
                if ADD_COLUMNS_PREFIX==1:
                    cname = str(i) +'_'+ re.sub('[() .-/&-]', '_', cheader)        
                else:
                    cname = re.sub('[() .-/&-]', '_', cheader)
                #cname =  re.sub('[() .-]', '_', cheader)
                cname = transform_chars(cname) #.lower()
                cname = re.sub('_{2,}', '_', cname)
                #cname = cheader
                
            #cname = re.sub('(?P<a>.{6,})_{1,}',  '\g<a>', cname)
            while cname[-1] == '_':
                cname = cname[:-1]
            
            # instead nvarchar(max) use nvarchar(4000) because index can't be created on (max) version
            res +=  "\n"+" "*8 + ', [' + cname +'] nvarchar(4000) default \'\''
            ##res +=  "\n"+" "*8 + ', ' + str(i) +' varchar('+str(out_h[i]+1) + ')'
            #res +=  "\n"+" "*8 + ', ' + str(i) +' [nvarchar(4000) NULL'
            #res +=  "\n"+" "*8 + ', ' + str(i) +'_'+ re.sub('\s{1,}', '', header_l[int(i[1:])-1]) +' VARCHAR('+str(out_h[i]+1) + ')'

        else:
            #res +=  "\n"+" "*8 + ', ' + str(i) +' varchar('+str(out_h[i]+1) + ')'
            res +=  "\n"+" "*8 + ', [' + str(i) +'] nvarchar(4000) default \'\''
            
    res = re.sub("\(\n        ,", "(\n         ", res)
    res += "\n        ) on [primary]\n    go\n"

    if res != '': return res
    else: return 0

    
for fidx, f in enumerate(glob.glob(TASK_DIR + FILES_MASK)):

    if len(DB_SCHEMA) == 1: DB_SCHEMA_FIDX = DB_SCHEMA[0]
    else: DB_SCHEMA_FIDX = DB_SCHEMA[fidx]

    if len(TABLE_PREFIX) == 1: TABLE_PREFIX_FIDX = TABLE_PREFIX[0]
    else: TABLE_PREFIX_FIDX = TABLE_PREFIX[fidx]

    if len(TABLE_APPENDIX) == 1: TABLE_APPENDIX_FIDX = TABLE_APPENDIX[0]
    else: TABLE_APPENDIX_FIDX = TABLE_APPENDIX[fidx]

    sqlfn = '%s.01.mssql_create_tables.sql' % (DB_SCHEMA_FIDX, )
    o = codecs.open(sqlfn, 'a', 'utf-8')
    cmd.append('call mssql_run.cmd %s\n' % (sqlfn, ))

    txt = '''
    --use %s
    go

    if not exists (select schema_name from information_schema.schemata where schema_name = '%s' ) 
    begin
        exec sp_executesql N'create schema %s'
    end
    ''' % (DB_NAME, DB_SCHEMA_FIDX, DB_SCHEMA_FIDX)
    o.write('--use %s\ngo\n--create schema %s\n' % (DB_NAME,DB_SCHEMA))
    o.write(txt)

    if os.path.isdir(f) is True:
        print ('    DIRECTORY SKIPPED:', f)
    else:
        fname = f.split('\x5C')[-1]
        print ('CT>', fname)
        #fname = string.split(fname, '.')[0] #.lower()
        fname = re.sub('[() .-]', '_', fname)
        if len(fname) > 128: fname = fname[64:]
        #tname = re.sub('uisx_', '', re.sub('[ -]', '_', fname))
        #tname = fname[:-4] # removing _csv
        tname = fname[:REMOVE_EXT] # .utf16le.dat

        tname = TABLE_PREFIX_FIDX + transform_chars(tname).lower() + TABLE_APPENDIX_FIDX
        
        o.write(createTableString(f, tname
                                , tableSchema=DB_SCHEMA_FIDX
                                , colDelimiter=FILES_COLUMN_DELIMITER
                                , hasHeader=FILES_HAS_HEADER
                                ))

    o.close()


## #    BULK INSERT ##

for fidx, f  in enumerate(glob.glob(TASK_DIR + FILES_MASK)):

    if len(DB_SCHEMA) == 1: DB_SCHEMA_FIDX = DB_SCHEMA[0]
    else:  DB_SCHEMA_FIDX = DB_SCHEMA[fidx]

    if len(TABLE_PREFIX) == 1: TABLE_PREFIX_FIDX = TABLE_PREFIX[0]
    else: TABLE_PREFIX_FIDX = TABLE_PREFIX[fidx]

    if len(TABLE_APPENDIX) == 1: TABLE_APPENDIX_FIDX = TABLE_APPENDIX[0]
    else: TABLE_APPENDIX_FIDX = TABLE_APPENDIX[fidx]
    
    bi_sql_fn = '%s.02.mssql_bulk_insert.sql' % (DB_SCHEMA_FIDX, )
    dc_sql_fn = '%s.03.mssql_dt_columns.sql' % (DB_SCHEMA_FIDX, )
    obi = open(bi_sql_fn, 'a')
    odc = open(dc_sql_fn, 'a')
    cmd.append('call mssql_run.cmd %s\n' % (bi_sql_fn, ))
    cmd.append('call mssql_run.cmd %s\n' % (dc_sql_fn, ))
    
    obi.write('\n--use %s\ngo\n\n' % (DB_NAME,))
    odc.write('\n--use %s\ngo\n\n' % (DB_NAME,))
    
    if os.path.isdir(f) is True:
        print( '    DIRECTORY SKIPPED:', f )
    else:
        fname = f.split('\x5C')[-1]
        print ( 'BI>', fname )
        #fname = string.split(fname, '.')[0]#.lower()
        fname = re.sub('[() .-]', '_', fname)
        if len(fname) > 128: fname = fname[64:]

        #tname = re.sub('[ -]', '_', fname)
        #tname = fname[:-4] # removing _csv
        tname = fname[:REMOVE_EXT] # removing extension
        tname = TABLE_PREFIX_FIDX + transform_chars(tname).lower() + TABLE_APPENDIX_FIDX
        #tname = re.sub('uisx_', '', tname)
        
        username = os.environ.get( "USERNAME" )
        
        sqlbi = r'''
        print  'START :: [%s].[%s]'
        go
        BEGIN
          bulk insert [%s].[%s]
          from '%s'
          with (
               firstrow        = %s                 -- expecting 2 if header present, 1 if no header present
             , codepage        = 'utf-16'           -- '1252' '1250'
             , datafiletype    = 'widechar'         -- 'char'
             , fieldterminator = '%s'               -- '^' ';' '\t'
             , rowterminator   = '%s'               -- '\n'
             , errorfile       = '%simport.err.%s'  -- error file name
             , tablock         -- speeds up the bulk insert; it locks the table as a whole
          );
        END
        ''' % (DB_SCHEMA_FIDX, tname
             , DB_SCHEMA_FIDX, tname
             , f.lower()
             , FIRST_DATA_ROW
             , FILES_COLUMN_DELIMITER
             , FILES_ROW_TERMINATOR
             , TASK_DIR + '\x5C'
             , tname)

        obi.write(sqlbi)

        # (200) is used for SOURCE_FILE because when creating index 900 is the limit, 
        # so for one nvarchar(200) it is already 400 used up, 500 left 
        sql_dt_columns = '''
        BEGIN
         alter table [%s].[%s]
           add DT_LOAD_ID           int identity(1,1)
             , DT_LOAD_SOURCE_PATH  nvarchar(4000)
             , DT_LOAD_SOURCE_FILE  nvarchar(200)

             , DT_LOAD_TIME         datetime
             , DT_LOAD_USER         nvarchar(50)
             , DT_STAGING_QC        nvarchar(50);
        END
        go
        
        BEGIN
        update [%s].[%s]
           set DT_LOAD_USER         = '%s'
             , DT_LOAD_TIME         = GETDATE()
             , DT_LOAD_SOURCE_PATH  = '%s'
             , DT_LOAD_SOURCE_FILE  = '%s';
        END
        \n\n\n
        ''' % (DB_SCHEMA_FIDX, tname
             , DB_SCHEMA_FIDX, tname
             , username, f, f.split('\x5C')[-1])
             #, DB_SCHEMA, tname --, DT_SOURCE    = '[%s].[%s]'

        sql_dt_columns_2 = '''
        BEGIN
         alter table [%s].[%s]
           add DT_LOAD_ID       int identity(1,1)
             , DT_LOAD_SOURCE_PATH  nvarchar(4000)
             , DT_LOAD_SOURCE_FILE  nvarchar(200);
        END
        go
        
        BEGIN
        update [%s].[%s]
           set DT_LOAD_SOURCE_PATH    = '%s'
           , DT_LOAD_SOURCE_FILE  = '%s';
        END
        \n\n\n
        ''' % (DB_SCHEMA_FIDX, tname
             , DB_SCHEMA_FIDX, tname
             , f, f.split('\x5C')[-1]) #f.split('\x5C')[-1])
             
        if ADD_DT_COLUMNS == 1:
            odc.write(sql_dt_columns)
        if ADD_DT_COLUMNS == 2:
            odc.write(sql_dt_columns_2)

    o.close()

## #    LRTRIM columns ##

if 1: # switch this to 0 if not required
    for f in glob.glob('*mssql_create_tables.sql'):

        DB_SCHEMA_FIDX = f.split('.')[0]
        ilines = codecs.open('%s.01.mssql_create_tables.sql' % (DB_SCHEMA_FIDX), 'r', 'utf-8').readlines()
        
        sqlfn = '%s.04.mssql_lrtrim.sql' % (DB_SCHEMA_FIDX)
        o = codecs.open(sqlfn, 'a','utf-8')
        cmd.append('call mssql_run.cmd %s\n' % (sqlfn, ))

        for line in ilines:
            if  line.find('if exists') != -1 or \
                line.find('drop table') != -1 or \
                line.find('if  object_id') != -1 or \
                line.find('if exists') != -1:
                pass

            elif line.find('create table') != -1:
                line = re.sub('create table', 'update', line)
                line = re.sub('\(', '', line)
                o.write(line)

            elif line[:11] in ('          [', '        , ['):
                if line[:11] == '          [': line = '      set [' + line[11:]
                column = '= ltrim(rtrim( [' + line[11:line.find('nvarchar')] +'))'
                line = re.sub('nvarchar\(4000\) default \'\'', column, line)
                o.write(line)
                
            elif line[:11] in ('        ) o'):
                pass

            else:
                o.write(line)
            
        o.close()


## #    remove DQUOTES ##

if 0: # switch this to 0 if not required

    ilines = codecs.open('mssql_create_tables.sql', 'r', 'utf-8').readlines()
    o = codecs.open('mssql_rm_dquotes.sql', 'w', 'utf-8')

    for line in ilines:
        if  line.find('if exists') != -1 or \
            line.find('drop table') != -1 or \
            line.find('if exists') != -1:
            pass

        elif line.find('create table') != -1:
            line = re.sub('create table', 'update', line)
            line = re.sub('\(', '', line)
            o.write(line)

        elif line[:11] in ('          [', '        , ['):
            if line[:11] == '          [': line = '      set [' + line[11:]
            
            cname = line[11:line.find('nvarchar')-2]
            
            eqto = '= (case substring(reverse('+cname+'), 1, 1) = \'"\' then reverse(substring(reverse([' + cname + ']), 2, 4000)) else ['+cname+'] end);'
            o.write(re.sub('nvarchar\(4000\) default \'\'', eqto, line))

            eqto = '= (case substring('+cname+', 1, 1) = \'"\' then substring([' + cname + '], 2, 4000) else ['+cname+'] end);'
            o.write(re.sub('nvarchar\(4000\) default \'\'', eqto, line))

            o.write('\n')

            
        elif line[:11] in ('        ) o'):
            pass

        else:
            o.write(line)
        
    o.close()


#if substring(reverse([c004_DATUM_VZNIKU_D]), 1, 1) = '"'    update [etlt002].[par_dr20140220] set [c004_DATUM_VZNIKU_D] = reverse(substring(reverse([c004_DATUM_VZNIKU_D]), 2, 4000));

#ocmd = open('#run_all_sql.cmd', 'w')
#ocmd.write('call ..\..\setup_env.cmd\n')

#ocmd.write('echo. > %log%\n')
#ocmd.write(string.join(sorted(set(cmd)), ''))

#ocmd.write('powershell -Command "& {Select-String -Path mssql_run.cmd.log -pattern Msg;Move-Item mssql_run.cmd.log "mssql_run.cmd.$(Get-Date -Format "yyyyMMdd_HHmmss").log";}"')

