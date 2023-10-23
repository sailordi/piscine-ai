import os
import subprocess
import pandas as pd
import numpy as np

def download_files(urls):
    folder = '../data'
    
    # Check if foder exists
    if not os.path.exists(folder):
        os.makedirs(folder)   
    
    for u in urls:
        filename = u.split("/")
        filename = filename[-1]
        
        print(u)
        print(filename)
        
        # Check if the file exists
        if not os.path.exists(folder+filename):
            # If the file doesn't exist, download it
            subprocess.run(['wget', u, '-P', folder])
        else:
            print(f"{folder+filename} already exists.")    

def changeTypesDf(df): 
    # Iterate over every column
    for col in df.columns:
        if col == "Date":
            df[col] = pd.to_datetime(df[col])
        # Check if the column is numeric
        if np.issubdtype(df[col].dtype, np.number):
            # Check if the column can be represented by an integer
            if df[col].min() >= 0 and df[col].max() <= np.iinfo(np.int32).max:
                # If the column is numeric and can be represented by an integer, convert it to int32
                df[col] = df[col].astype(np.int32)
            else:
                # If the column is numeric but cannot be represented by an integer, convert it to float32
                df[col] = df[col].astype(np.float32)

    return df
         
def memory_reducer(paths):
    prices = pd.DataFrame()
    sp500 = pd.DataFrame()
    
    for p in paths: 
        if not os.path.exists(p):
            print(f"{p} does not exist git gud.")  
            os._exit(1)
            
        if "sp500" in p:
            sp500 = pd.read_csv(p,sep=',',low_memory=False)
        else:
            prices = pd.read_csv(p,sep=',',low_memory=False)        
    
    prices = changeTypesDf(prices)
    sp500 = changeTypesDf(sp500)
    
    prices.set_index('Date')
    sp500.set_index('Date')
        
    return prices, sp500