# downloads stock data for yesterday only
# mind that this script outputs nothing for bank holidays

from datetime import date, timedelta
import csv
import os
import pandas_datareader.data as web
import quandl

#############
### SETUP ###

today = date.today()                    # automatic date input
# today = date(2017, 7, 27)                # manual date input (YYYY, M, D)
yesterday = today - timedelta(1)

# input file (relative path)
input_file_google = 'companies_google.csv'
input_file_quandl = 'companies_quandl.csv'

# output file (relative path)
output_dir = 'stock_data'
output_file = output_dir + '/' + 'stock_' + str(yesterday) + '.csv'

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
            df = web.DataReader(ticker, 'google', yesterday, today)
            # add company column
            df['Company'] = name
            # append to output file
            with open(output_file, 'a') as f:
                df.iloc[0:1].to_csv(f, header=False)
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
            df_full = quandl.get(ticker, start_date=yesterday, end_date=today)
            df = df_full[[row[2].strip(), row[3].strip(), row[4].strip(), row[5].strip(), row[6].strip()]].copy()
            # add company column
            df['Company'] = name
            # append to output file
            with open(output_file, 'a') as f:
                df.to_csv(f, header=False)
        except Exception as e:
            print(e)
