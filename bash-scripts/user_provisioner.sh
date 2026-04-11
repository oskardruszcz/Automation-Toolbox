#!/bin/bash

if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root (use sudo)."
   exit 1
fi

if [[ -z $1 ]]; then
    echo "Usage: $0 <input_file>"
    exit 1
fi

INPUT_FILE=$1

if [[ ! -f $INPUT_FILE ]]; then
    echo "Error: File $INPUT_FILE not found."
    exit 1
fi

echo "--- Starting User Provisioning ---"

while IFS= read -r username || [[ -n "$username" ]]; do
    # Skip empty lines or comments
    [[ -z "$username" || "$username" =~ ^# ]] && continue

    if id "$username" &>/dev/null; then
        echo "[SKIP] User '$username' already exists."
    else
        password=$(openssl rand -base64 12)

        useradd -m -s /bin/bash "$username"

        echo "$username:$password" | chpasswd

        chage -d 0 "$username"

        chmod 750 "/home/$username"

        echo "[SUCCESS] Created user: $username | Temporary Password: $password"
    fi
    
done < "$INPUT_FILE"

echo "--- Provisioning Complete ---"
