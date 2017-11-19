#! /usr/bin/python
# -*- coding: cp1250 -*-

import sys, codecs, glob, re
from datetime import datetime, timedelta

class lines:
    ''' read big text file as iterator
    '''
    def __init__(self , fpath, encoding=''):
        self.file_path = fpath
        # be able to define (to avoid guessing) input encoding 
        self.file_encoding = encoding
        
        #self.file_handle = open(fpath, 'r')
        #self.file_handle = open(fpath, 'U')
        # 2010-09-30_2017 vp, do not assume newline characters, read in binary mode
        if   self.file_encoding == 'utf-8':
            self.file_handle = codecs.open(self.file_path, 'rb', 'utf-8')#, errors='ignore')
        elif self.file_encoding in ('utf-8-sig'):
            self.file_handle = codecs.open(self.file_path, 'rb', 'utf-8-sig')#, errors='ignore')
        elif self.file_encoding in ('win1250', 'cp1250'):
            self.file_handle = codecs.open(self.file_path, 'rb', 'cp1250')#, errors='ignore')
        elif self.file_encoding in ('cp852'):
            self.file_handle = codecs.open(self.file_path, 'rb', 'cp852')#, errors='ignore')
        else:
            self.file_handle = open(self.file_path, 'rb')


    def __getitem__( self , index ):
        line = self.file_handle.readline()
        if line:
            return line
        else:
            raise IndexError

def main(fmask, enc):
    # enc ... utf-8, cp1250, cp852

    for f in glob.glob(fmask):
        print(f)
        fname = f.split('\x5C')[-1]
        o = codecs.open('_fe_'+ fname[16:], 'w', 'utf-8')#, errors='ignore') # cp852, cp1250
        lino = 0
        for line in lines(f, enc):
            lino += 1

            # line = re.sub('\x0D\x0A', '', line)
            # line = re.sub('\x0D', '', line)
            # line = re.sub('\x0A', '', line)

            #line = line[:-2]
            if lino == 1: 
                o.write('%s|%s' % ('DT_FNAME', line))
            elif lino != 1 and line[0:6] == 'DT_EOL':
                o.write('\x0D\x0A%s|%s' % (fname, line))
            else:
                o.write('%s' % (line,))
        o.close()


#main('../20160516*_OrderItem.dat', 'utf-8-sig')
#dt = '{:%Y%m%d}'.format(datetime.today() + timedelta(days=-1)) # yesterday

def fileNameIndex(pathFileMask='', iStartEnd=[]):
    o = []
    for f in glob.glob(pathFileMask):
        fn = f.split('\x5C')[-1] #file name
        o.append(fn[iStartEnd[0]:iStartEnd[1]])
    return sorted(o)[-1]
    
# highest date in folder etlt030_sftp217_Feedo_ExportData
dt = fileNameIndex(r'../../etlt030_vega_data/20*T*.csv', [0,8])
# print(dt)

#main('../../etlt030_sftp217_Feedo_ExportData/'+dt+'T000500_'+'*.dat', 'utf-8')
#main('../../etlt030_sftp217_Feedo_ExportData/20160623T174837_Produc*.dat', 'utf-8')
#main('../../etlt030_sftp217_Feedo_ExportData/20161013T11*.dat', 'utf-8')

# 20170508_1906 VIP; we want to process all files because in etlt064 (PDG) we are skipping column delimiters check

#main('../../etlt030_sftp217_Feedo_ExportData/'+dt+'T2155'+'*.dat', 'utf-8')
main('../../etlt030_vega_data/'+dt+'T*.csv', 'utf-8')

'''
main('../../etlt030_sftp217_Feedo_ExportData/'+dt+'T0005'+'*CreditNote.dat', 'utf-8')
main('../../etlt030_sftp217_Feedo_ExportData/'+dt+'T0005'+'*CreditNoteItem.dat', 'utf-8')
main('../../etlt030_sftp217_Feedo_ExportData/'+dt+'T0005'+'*Customer.dat', 'utf-8')
main('../../etlt030_sftp217_Feedo_ExportData/'+dt+'T0005'+'*DeliveryTime.dat', 'utf-8')
main('../../etlt030_sftp217_Feedo_ExportData/'+dt+'T0005'+'*HeurekaReview.dat', 'utf-8')
main('../../etlt030_sftp217_Feedo_ExportData/'+dt+'T0005'+'*Invoice.dat', 'utf-8')
main('../../etlt030_sftp217_Feedo_ExportData/'+dt+'T0005'+'*InvoiceItem.dat', 'utf-8')
main('../../etlt030_sftp217_Feedo_ExportData/'+dt+'T0005'+'*Margin.dat', 'utf-8')
main('../../etlt030_sftp217_Feedo_ExportData/'+dt+'T0005'+'*PaymentMethod.dat', 'utf-8')
main('../../etlt030_sftp217_Feedo_ExportData/'+dt+'T0005'+'*Stock.dat', 'utf-8')
main('../../etlt030_sftp217_Feedo_ExportData/'+dt+'T0005'+'*VirtualPack.dat', 'utf-8')
'''
