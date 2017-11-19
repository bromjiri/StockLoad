# downloads stock data for specified date range
# mind that this script outputs nothing for bank holidays

from datetime import date, timedelta
import csv
import os
import pandas_datareader.data as web
import quandl

#############
### SETUP ###

# start and end date of required stock data (YYYY, M, D)
start = date(2017, 3, 1)    # including
end = date(2017, 3, 31)     # including

# input file (relative path)
input_file_google = 'companies_google.csv'
input_file_quandl = 'companies_quandl.csv'


# output file (relative path)
output_dir = 'stock_data'
output_file = output_dir + '/' + 'stock_' + str(start) + '_' + str(end) + '.csv'

##############
#### CODE ####

# create output dir
os.makedirs(output_dir, exist_ok=True)

# create output file with header
with open(output_file, 'w') as f:
    f.write('Date,Open,High,Low,Close,Volume,Company\n')

# process google
with open(input_file_google, 'r') as comp:
    reader = csv.reader(comp)

    # for each company
    for row in reader:
        name = str(row[0])
        ticker = str(row[1]).strip()
        print('\n' + name)

        try:
            # download stock data
            df = web.DataReader(ticker, 'google', start, end)
            # add company column
            df['Company'] = name
            # append to output file
            with open(output_file, 'a') as f:
                df.to_csv(f, header=False)
        except Exception as e:
            print(e)


# process quandl
with open(input_file_quandl, 'r') as comp:
    reader = csv.reader(comp)

    # for each company
    for row in reader:
        name = str(row[0])
        ticker = str(row[1]).strip()
        print('\n' + name)

        try:
            # download stock data
            df_full = quandl.get(ticker, start_date=start, end_date=end)
            df = df_full[[row[2].strip(), row[3].strip(), row[4].strip(), row[5].strip(), row[6].strip()]].copy()
            # add company column
            df['Company'] = name
            # append to output file
            with open(output_file, 'a') as f:
                df.to_csv(f, header=False)
        except Exception as e:
            print(e)
