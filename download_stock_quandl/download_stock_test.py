from datetime import date, timedelta, datetime
from pandas_datareader import data, wb

today = date(2017, 9, 1)
yesterday = today - timedelta(1)

df = data.DataReader('YHOO', 'google', yesterday, today)
print(df.head())

print(datetime.today())

# from googlefinance.client import get_price_data, get_prices_data, get_prices_time_data
#
# # Dow Jones
# param = {
#     'q': "500530", # Stock symbol (ex: "AAPL")
#     'i': "86400", # Interval size in seconds ("86400" = 1 day intervals)
#     'x': "NSE", # Stock exchange symbol on which stock is traded (ex: "NASD")
#     'p': "2017-08-30" # Period (Ex: "1Y" = 1 year)
# }
# # get price data (return pandas dataframe)
# df = get_price_data(param)
# print(df)