# downloads stock data for dates specified in datelist.txt
# mind that this script outputs nothing for bank holidays

from datetime import date, timedelta
import csv
import os
# pandas package required
import quandl
quandl.ApiConfig.api_key = "DUzF74wLztBcn5zgLZjy"
#############
### SETUP ###

# input file (relative path)
input_file = 'companies_quandl.csv'

# output file (relative path)
output_dir = 'stock_data'
output_file = output_dir + '/' + 'stock_datelist_' + str(date.today()) + '.csv'

##############
#### CODE ####

# create output dir
os.makedirs(output_dir, exist_ok=True)

# create output file with header
with open(output_file, 'w') as f:
    f.write('Date,Open,High,Low,Close,Volume,Company\n')

# open input file
with open(input_file, 'r') as comp:
    reader = csv.reader(comp)

    # for each company
    for row in reader:
        name = str(row[0])
        ticker = str(row[1]).strip()
        print('\n' + name)

        try:
            with open('datelist.txt', 'r') as datelist:
                for day in datelist:
                    # download stock data
                    df_full = quandl.get(ticker, start_date=day, end_date=day)
                    df = df_full[[row[2].strip(), row[3].strip(), row[4].strip(), row[5].strip(), row[6].strip()]].copy()
                    # add company column
                    df['Company'] = name
                    # append to output file
                    print(df)
                    with open(output_file, 'a') as f:
                        df.to_csv(f, header=False)
        except Exception as e:
            print(e)
