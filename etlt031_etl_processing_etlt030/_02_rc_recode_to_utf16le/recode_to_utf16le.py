#! /usr/bin/python
# -*- coding: cp1250 -*-

import sys, codecs, glob, re

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
        #if fname == '_rd_fe_OrderItem.csv':
        #    o = codecs.open('_rf'+f.split('\x5C')[-1], 'w', 'utf-16')#, errors='ignore') # cp852, cp1250
        #else:
        o = codecs.open('_rc'+f.split('\x5C')[-1], 'w', 'utf-16')#, errors='ignore') # cp852, cp1250
        for line in lines(f, enc):
            o.write(line)
        o.close()
      
main('../_01_rd_replace_delimiters/_rd_*.csv', 'utf-8-sig')
