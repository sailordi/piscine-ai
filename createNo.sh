jupiter_create() {
    env_name=$1
    notebook_name=$2

    cd "$env_name"

    echo "{ \"cells\": [], \"metadata\": {}, \"nbformat\": 4, \"nbformat_minor\": 2 }" > "$notebook_name.ipynb"

    cd ..
}


# Input virtual environment name
read -p "Enter the name for the virtual environment: " env_name

# Input name for jupiter notbook
read -p "Enter the notebook name (name format will be Notebook_ your input): " notebook_name

if [[ -z "$notebook_name" ]]; then
    echo "Notebook name is empty. Exiting script."
    exit 1

notebook_name= "Notebook_"+notebook_name

# Activate the virtual environment
source "$env_name/bin/activate" 

jupiter_create "$env_name" "$notebook_name"

# Deactivate the virtual environment when done
deactivate  