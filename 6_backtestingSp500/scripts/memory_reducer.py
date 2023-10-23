import os
import wget
import pandas as pd

def download_files(urls):
    folder = 'data'
    
    # Check if foder exists
    if not os.path.exists(folder):
        os.makedirs(folder)   
    
    for u in urls:
        filename = u.split("/").last()
        # Check if the file exists
        if not os.path.exists(folder+filename):
            # If the file doesn't exist, download it
            wget.downlad(u, out=folder+filename)
        else:
            print(f"{folder+filename} already exists.")    
         
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
        
    return prices, sp500