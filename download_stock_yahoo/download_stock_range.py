# downloads stock data for specified date range
# mind that this script outputs nothing for bank holidays

from datetime import date, timedelta
import csv
import os
import pandas_datareader.data as web
from time import sleep
#############
### SETUP ###

# start and end date of required stock data (YYYY, M, D)
start = date(2017, 9, 27)       # including
end = date(2017, 9, 29)         # including

# input file (relative path)
input_file = 'companies.csv'

# output file (relative path)
output_dir = 'stock_data'
output_file = output_dir + '/' + 'stock_' + str(start) + '_' + str(end) + '.csv'

##############
#### CODE ####

# create output dir
os.makedirs(output_dir, exist_ok=True)

# create output file with header
with open(output_file, 'w') as f:
    f.write('Date,Open,High,Low,Close,Adj Close,Volume,Company\n')

# open input file
with open(input_file, 'r') as comp:
    reader = csv.reader(comp)

    # for each company
    for row in reader:
        name = str(row[0])
        ticker = str(row[1]).strip()
        print('\n' + name)

        try:
            # download stock data
            df = web.DataReader(ticker, 'yahoo', start, end)
            sleep(5)
            # add company column
            df['Company'] = name
            # append to output file
            with open(output_file, 'a') as f:
                df.to_csv(f, header=False)
        except Exception as e:
            print(e)
