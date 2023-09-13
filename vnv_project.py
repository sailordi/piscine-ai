import subprocess
import sys
import os

def create_env(env_name, python_version="3.8"):
    # Create a Python virtual environment using conda
    subprocess.run([f"python{python_version}", "-m", "venv", env_name], check=True)
    
def handle_libraries(env_name,lib):
    file_name = "requirements.txt"
    requirements_path = os.path.join(env_name, file_name)
    
    with open(requirements_path, "w") as requirements_file: requirements_file.write("\n".join(lib))

if __name__ == "__main__":
    # Input version of Python
    python_version = input("Enter the Python version (default is 3.8): ") or "3.8"

    # Input virtual environment name
    env_name = input("Enter the name for the virtual environment: ")

    # Input libraries
    libraries = input("Enter required libraries (comma-separated): ").split(",")

    create_env(env_name,python_version)
    handle_libraries(env_name,libraries)