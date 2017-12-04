# downloads stock data for specified date range
# mind that this script outputs nothing for bank holidays

from datetime import date, timedelta
from time import sleep
import csv
import os
from alpha_vantage.timeseries import TimeSeries
from download_stock_av import api_key

#############
### SETUP ###

# interval between API calls [seconds]
API_CALL_FREQUENCY = 30

# start and end date of required stock data (YYYY, M, D)
start = date(2017, 11, 27)    # including
end = date(2017, 11, 29)     # including

# input file (relative path)
input_file = 'companies.csv'

# output file (relative path)
output_dir = 'stock_data'
output_file = output_dir + '/' + 'stock_' + str(start) + '_' + str(end) + '.csv'

##############
#### CODE ####

# create output dir
os.makedirs(output_dir, exist_ok=True)

# load api key
ts = TimeSeries(key=api_key.KEY, output_format='pandas')

# create output file with header
with open(output_file, 'w') as f:
    f.write('Date,Open,High,Low,Close,Volume,Company\n')

# process google
with open(input_file, 'r') as comp:
    reader = csv.reader(comp)

    # for each company
    for row in reader:
        name = str(row[0])
        ticker = str(row[1]).strip()
        print('\n' + name)

        try:
            # download stock data
            df_full, meta_data = ts.get_daily(symbol=ticker, outputsize='full')
            sleep(API_CALL_FREQUENCY)
            # add company column
            df_full['Company'] = name
            # get required date range
            df = df_full.loc[str(start):str(end)]
            # append to output file
            with open(output_file, 'a') as f:
                df.to_csv(f, header=False)
        except Exception as e:
            print(e)
