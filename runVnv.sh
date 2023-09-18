# Input virtual environment name
read -p "Enter the name for the virtual environment: " env_name
# Input name for jupiter notbook
read -p "Enter the notebook name (default is Notebook_${env_name}): " notebook_name
notebook_name=${notebook_name:-"Notebook_${env_name}"}

cd "$env_name"

echo "{ \"cells\": [], \"metadata\": {}, \"nbformat\": 4, \"nbformat_minor\": 2 }" > "$notebook_name.ipynb"

# Launch Jupyter Notebook on port 8891 with the specified notebook name
jupyter notebook --port $port $notebook_name.ipynb

cd ..