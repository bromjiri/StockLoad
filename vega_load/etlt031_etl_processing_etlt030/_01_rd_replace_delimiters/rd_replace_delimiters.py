
import glob, csv, re, codecs

def process(fm, cd, cc={}, inspect_mode=False):
    '''
    fe = file
    cd = column delimiter
    cc = ho many columns are expected in file
    '''
    cc_generated = {}
    for f in glob.glob(fm):
        print (f)
        
        fname = f.split('\x5C')[-1][:-4] + '.csv'
        o = codecs.open('_rd'+ fname, 'wb', 'utf-8')
        #o = open('_rd_output.csv', 'ab')
        e = codecs.open('_err_rd_'+ fname, 'wb', 'utf-8')
        fi = codecs.open('_fileinfo_.txtdat', 'ab', 'utf-8')
        i = codecs.open(f, 'rb', 'utf-8')
        
        csv_reader = csv.reader(i, delimiter=cd, quotechar='"')

        lino = 0
        for line_columns in csv_reader:
            if inspect_mode and lino > 3: break
            lino += 1
            #cols = [re.sub(';', ' ', x) for x in cols]
            line_columns = [re.sub('\t', ' ', x) for x in line_columns]
            line_columns = [re.sub('"', '', x) for x in line_columns]
            
            line_columns = [re.sub('\x0D\x0A', '', x) for x in line_columns]

            if fname in cc_generated:
                pass
            else:
                cc_generated.update({fname:len(line_columns)})

            
            if len(line_columns) != cc_generated[fname]: print (str(len(line_columns)))

            if len(line_columns) == cc_generated[fname]:
                o.write('\t'.join(line_columns) + '\x0D\x0A')
                #o.write(re.sub('_', '-', fname[:7]) +'\t' + '\t'.join(line_columns) + '\x0D\x0A')
            else:
                e.write('\t'.join(line_columns) + '\x0D\x0A')
            

        fi.write('%s\t%s\t%s\x0D\x0A' % (f.split('\x5C')[-1], str(len(line_columns)), str(line_columns)))
                
        o.close()
        i.close()
    if inspect_mode: print(cc_generated)


#r'W:\space_da_140\projects\2015\Q1\23_FA_CET21\DATA_RECEIVED_WORKCOPY\20150126_2106_js_data\LedgerTrans4Audit701_current_01-122014\*.csv', 
#path = r'W:\space_da_140\projects\2015\Q4\01_PA_FOXCONN\DATA_RECEIVED_WORKCOPY\20151015_1853_jz_payment_data'

process(fm=r'../_00_fe_fix_eols/_fe_*.csv', cd=',', cc={}, inspect_mode=False)


