from alpha_vantage.timeseries import TimeSeries
from download_stock_av import api_key


ts = TimeSeries(key=api_key.KEY, output_format='pandas')
df, meta_data = ts.get_daily(symbol='VIG.VI', outputsize='compact')

# print(data)


print(df.loc[['2017-11-28']])