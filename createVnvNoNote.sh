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
    
    if [ -n "$2" ]; then
        # Write libraries to requirements.txt
        echo "$libraries" | tr ',' '\n' > "$requirements_path"
    fi
}

install_libraries() {
    env_name=$1

    python -m ensurepip
    python -m ensurepip --upgrade
    python -m pip install --upgrade pip
    pip install -r "$env_name/requirements.txt"
    pip install ipykernel
    python -m ipykernel install --user --name="$env_name"
}

# Input version of Python
read -p "Enter the Python version (default is 3.10): " python_version
python_version=${python_version:-3.10}

# Input virtual environment name
read -p "Enter the name for the virtual environment: " env_name

# Input libraries
read -p "Enter required libraries (comma-separated leave empty to use requirements.txt): " libraries

# Prompt the user for the port number
read -p "Enter the port number (default is 8891): " port_number
port_number="${port_number:-8891}"

create_env "$python_version" "$env_name"
handle_libraries "$env_name" "$libraries"

# Activate the virtual environment
source "$env_name/bin/activate" 

install_libraries "$env_name"

# Launch Jupyter Notebook on port 8891 with the specified notebook name
    #jupyter notebook --ip=127.0.0.1 --port $port $notebook_name.ipynb

# Launch Jupyter lab on port 8891 with the specified notebook name
jupyter lab --ip=127.0.0.1 --port $port_number

# Deactivate the virtual environment when done
deactivate  