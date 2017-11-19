
import os, sys

DB_SCHEMA               = [ 'etlt032'         #'etlt034',
                         #  'etlt043' # err customer
                         #, 'etlt034' # err order 
                         #, 'etlt043' # customer
                         #, 'etlt032' # hview
                         #, 'etlt033' # invoice
                         #, 'etlt044' # margin
                         #, 'etlt034' # order
                         #, 'etlt035' # orderitem
                         #, 'etlt036' # paymentmethod
                         #, 'etlt037' # price
                         #, 'etlt038' # product
                         #, 'etlt045' # stoct
                         ] #, 'etlt113', 'etlt114', 'etlt114']
#DB_SCHEMA               = ['etlt034'] #, 'etlt113', 'etlt114', 'etlt114']
#data received

TABLE_PREFIX            = ['load_'] #, 'load_', 'load_', 'load_', 'load_', 'load_'] # 
TABLE_APPENDIX          = [''] #, '_dr20140228_1652', '_dr20140228_1652'

#CURR_PATH = os.path.dirname(os.path.abspath(__file__))
#TASK_DIR                = CURR_PATH

TASK_DIR                = r'C:\Users\jbrom\PycharmProjects\StockLoad\etlt031_etl_processing_etlt030\_02_rc_recode_to_utf16le'
#TASK_DIR                = os.path.dirname(os.path.realpath(__file__))[:-len('02_load_kw_variations')] + r'01_kword_list_variations_generator'

FILES_MASK              = r'\_rc_*.csv'

ADD_DT_COLUMNS          = 2 #1   # 0 = no; 2 = DT_ID ,DT_SOURCE_FILE, DT_SOURCE_PATH
ADD_COLUMNS_PREFIX      = 0 #c001,c002 etc.

FIRST_DATA_ROW          = 2 # expecting '2' if data has header, expecting '1' if no header
FILES_HAS_HEADER        = 1 # must be 1 if ADD_COLUMNS_PREFIX = 0 or if Header contains special characters













# in most cases no need to chenge ros below                          

DB_NAME                 = 'no_need_to_setup_or_change'
REMOVE_EXT              = -4 # .utf16le.dat = -12; .csv = -4
FILES_COLUMN_DELIMITER  =  '\t' # '\t' |
FILES_ROW_TERMINATOR    = r'\n' #\n 0x0a
POPEN_DEL_DRW_FILES     = r'del /Q %s\import.err.load_*' % (TASK_DIR, )
