# downloads stock data for yesterday only
# mind that this script outputs nothing for bank holidays

from datetime import date, timedelta
import csv
import os
# pandas package required
import pandas_datareader.data as web
# necessary to import new fix (changed in May 2017):
# https://stackoverflow.com/questions/44045158/python-pandas-datareader-no-longer-works-for-yahoo-finance-changed-url
import fix_yahoo_finance

#############
### SETUP ###

today = date.today()                    # automatic date input
# today = date(2017, 7, 27)                # manual date input (YYYY, M, D)
yesterday = today - timedelta(1)

# input file (relative path)
input_file = 'companies.csv'

# output file (relative path)
output_dir = 'stock_data'
output_file = output_dir + '/' + 'stock_' + str(yesterday) + '.csv'

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
            df = web.get_data_yahoo(ticker, yesterday, today)
            # add company column
            df['Company'] = name
            # append to output file
            with open(output_file, 'a') as f:
                df.iloc[0:1].to_csv(f, header=False)
        except Exception as e:
            print(e)
