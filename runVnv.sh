install_libraries() {
    python -m ensurepip
    python -m ensurepip --upgrade
    python -m pip install --upgrade pip
    pip install -r "requirements.txt"
    pip install ipykernel
    python -m ipykernel install --user --name="$env_name"
}

get_notbook_name() {
    # Input name for jupiter notbook
    read -p "Enter the notebook name (name format will be Notebook_ your input): " notebook_name

    if [ -z "$notebook_name" ]; then
        echo "Notebook name is empty. Exiting script."
        exit 1 
    else
        echo "Notebook_$notebook_name"
    fi
}

# Input virtual environment name
read -p "Enter the name for the virtual environment: " env_name

notebook_name=$(get_notbook_name)

# Prompt the user for the port number
read -p "Enter the port number (default is 8891): " port_number
port_number="${port_number:-8891}"

cd "$env_name"

# Activate the virtual environment
source "bin/activate" 

install_libraries "$env_name"

# Launch Jupyter Notebook on port 8891 with the specified notebook name
    #jupyter notebook --ip=127.0.0.1 --port $port $notebook_name.ipynb

# Launch Jupyter lab on port 8891 with the specified notebook name
jupyter lab --ip=127.0.0.1 --port $port_number $notebook_name.ipynb

# Deactivate the virtual environment when done
deactivate  

cd ..
