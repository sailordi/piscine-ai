from memory_reducer import *

# Download needed files if they do not exist
download_files(['https://raw.githubusercontent.com/01-edu/public/master/subjects/ai/backtesting-sp500/data/sp500.csv',
                'https://raw.githubusercontent.com/01-edu/public/master/subjects/ai/backtesting-sp500/data/stock_prices.csv'])

prices,sp500 = memory_reducer(['data/sp500.csv','data/stock_prices.csv'])

print(prices)
print(sp500)