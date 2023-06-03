#!/bin/bash

function clear_terminal() {
    if [ "$OSTYPE" == "msys" ] || [ "$OSTYPE" == "win32" ]; then
        cmd.exe /c cls
    else
        clear
    fi
}

function create_virtualenv() {
    while true; do
        read -p "Do you want to create a virtual environment? (Y/n) " choice
        choice=$(echo "$choice" | tr '[:upper:]' '[:lower:]')
        if [ "$choice" == "y" ]; then
            echo "Creating Virtual environment"
            python -m venv ../.venv
            if [ $? -ne 0 ]; then
                echo "Failed to create virtual environment."
                exit 1
            fi
            echo "Virtual environment created successfully."
            break
        elif [ "$choice" == "n" ]; then
            break
        else
            echo "Invalid choice. Please enter 'Y' or 'N'."
        fi
    done
}

function activate_virtualenv() {
    while true; do
        read -p "Do you want to activate the virtual environment? (Y/n) " choice
        choice=$(echo "$choice" | tr '[:upper:]' '[:lower:]')
        if [ "$choice" == "y" ]; then
            echo "Activating Virtual environment"
            source ../.venv/bin/activate
            if [ $? -ne 0 ]; then
                echo "Failed to activate virtual environment."
                exit 1
            fi
            echo "Virtual environment activated."
            break
        elif [ "$choice" == "n" ]; then
            break
        else
            echo "Invalid choice. Please enter 'Y' or 'N'."
        fi
    done
}

function install_requirements() {
    while true; do
        read -p "Do you want to install requirements? (Y/n) " choice
        choice=$(echo "$choice" | tr '[:upper:]' '[:lower:]')
        if [ "$choice" == "y" ]; then
            echo "Installing requirements"
            if [ "$OSTYPE" == "msys" ] || [ "$OSTYPE" == "win32" ]; then
                if ! pip install -r ../requirements.txt > nul; then
                    echo "Failed to install requirements."
                    exit 1
                fi
            else
                if ! pip3 install -r requirements.txt > /dev/null; then
                    echo "Failed to install requirements."
                    exit 1
                fi
            fi
            echo "Requirements installed successfully."
            break
        elif [ "$choice" == "n" ]; then
            break
        else
            echo "Invalid choice. Please enter 'Y' or 'N'."
        fi
    done
}

function run_migrations() {
    while true; do
        read -p "Do you want to run migrations? (Y/n) " choice
        choice=$(echo "$choice" | tr '[:upper:]' '[:lower:]')
        if [ "$choice" == "y" ]; then
            echo "Running migrations"
            python_executable="python"
            if [ "$OSTYPE" != "msys" ] && [ "$OSTYPE" != "win32" ]; then
                python_executable="python3"
            fi
            if [ "$OSTYPE" == "msys" ] || [ "$OSTYPE" == "win32" ]; then
                if ! "$python_executable" manage.py makemigrations && "$python_executable" manage.py migrate ; then
                    echo "Failed to run migrations."
                    exit 1
                fi
            else
                if ! "$python_executable" manage.py makemigrations && "$python_executable" manage.py migrate; then
                    echo "Failed to run migrations."
                    exit 1
                fi
            fi
            echo "Migrations executed successfully."
            break
        elif [ "$choice" == "n" ]; then
            break
        else
            echo "Invalid choice. Please enter 'Y' or 'N'."
        fi
    done
}

function collect_statics() {
    while true; do
        read -p "Do you want to collect static files? (Y/n) " choice
        choice=$(echo "$choice" | tr '[:upper:]' '[:lower:]')
        if [ "$choice" == "y" ]; then
            echo "Collecting Static Files"
            python_executable="python"
            if [ "$OSTYPE" != "msys" ] && [ "$OSTYPE" != "win32" ]; then
                python_executable="python3"
            fi
            if [ "$OSTYPE" == "msys" ] || [ "$OSTYPE" == "win32" ]; then
                if ! "$python_executable" manage.py collectstatic --noinput > nul; then
                    echo "Failed to collect static files."
                    exit 1
                fi
            else
                if ! "$python_executable" manage.py collectstatic --noinput > /dev/null; then
                    echo "Failed to collect static files."
                    exit 1
                fi
            fi
            echo "Static files collected successfully."
            break
        elif [ "$choice" == "n" ]; then
            break
        else
            echo "Invalid choice. Please enter 'Y' or 'N'."
        fi
    done
}

function rename_file() {
    while true; do
        read -p "Do you want to rename the file /nexis/info.py.example to /nexis/info.py? (Y/n) " choice
        choice=$(echo "$choice" | tr '[:upper:]' '[:lower:]')
        if [ "$choice" == "y" ]; then
            echo "Renaming file /nexis/info.py.example to /nexis/info.py"
            if [ -f "/nexis/info.py.example" ]; then
                mv "/nexis/info.py.example" "/nexis/info.py"
                if [ $? -ne 0 ]; then
                    echo "Failed to rename file."
                    exit 1
                fi
                echo "File renamed successfully."
            else
                echo "File ../nexis/info.py.example not found."
            fi
            break
        elif [ "$choice" == "n" ]; then
            break
        else
            echo "Invalid choice. Please enter 'Y' or 'N'."
        fi
    done
}

function main() {
    trap 'echo "Script interrupted by user." && exit 0' INT
    clear_terminal
    create_virtualenv
    clear_terminal
    activate_virtualenv
    clear_terminal
    install_requirements
    clear_terminal
    run_migrations
    clear_terminal
    collect_statics
    clear_terminal
    rename_file
    clear_terminal
    echo "All tasks completed successfully."
}

main
