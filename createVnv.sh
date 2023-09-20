#!/bin/bash

create_env() {
    # Create a Python virtual environment using conda
    python_version=$1
    env_name=$2
    python$python_version -m venv $env_name
}

handle_libraries() {
    env_name=$1
    # Jupiter notebok: libraries="$2,notebook"
    libraries="$2,jupyterlab"
    file_name="requirements.txt"
    requirements_path="$env_name/$file_name"
    
    # Write libraries to requirements.txt
    echo "$libraries" | tr ',' '\n' > "$requirements_path"
}

install_libraries() {
    env_name=$1

    pip install -r "$env_name/requirements.txt"
    python -m ipykernel install --user --name="$env_name"
}

jupiter_inst() {
    env_name=$1
    notebook_name=$2
    port=$3

    cd "$env_name"

    echo "{ \"cells\": [], \"metadata\": {}, \"nbformat\": 4, \"nbformat_minor\": 2 }" > "$notebook_name.ipynb"

    # Launch Jupyter Notebook on port 8891 with the specified notebook name
        #jupyter notebook --ip=127.0.0.1 --port $port $notebook_name.ipynb

    # Launch Jupyter lab on port 8891 with the specified notebook name
    jupyter lab --ip=127.0.0.1 --port $port $notebook_name.ipynb

    cd ..
}

# Input version of Python
read -p "Enter the Python version (default is 3.10): " python_version
python_version=${python_version:-3.10}

# Input virtual environment name
read -p "Enter the name for the virtual environment: " env_name

# Input libraries
read -p "Enter required libraries (comma-separated): " libraries

# Input name for jupiter notbook
read -p "Enter the notebook name (default is Notebook_${env_name}): " notebook_name
notebook_name=${notebook_name:-"Notebook_${env_name}"}

# Prompt the user for the port number
read -p "Enter the port number (default is 8891): " port_number
port_number="${port_number:-8891}"

create_env "$python_version" "$env_name"
handle_libraries "$env_name" "$libraries"

# Activate the virtual environment
source "$env_name/bin/activate" 

install_libraries "$env_name"
jupiter_inst "$env_name" "$notebook_name" "$port_number"

# Deactivate the virtual environment when done
deactivate  