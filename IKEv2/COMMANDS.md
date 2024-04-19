# User Management Script for IPsec(IKEv2) VPN

This Bash script simplifies user management for an IPsec VPN by allowing you to add or delete users from the `/etc/ipsec.secrets` file, which is utilized by StrongSwan IPsec for user authentication.

## Important
This script was not written entirely by me

## Requirements

- The script must be run on a system where IPsec VPN (StrongSwan) is installed.
- Root privileges are required for modifying the IPsec secrets file and managing VPN services.

## Usage

This script should be invoked with three arguments:
1. Action (`add` or `delete`)
2. Username
3. Password (only required when adding a user)

### Adding a User

```bash
sudo ./script_name.sh add username password
```
This command appends a new user entry to /etc/ipsec.secrets.

### Deleting a User

```bash
sudo ./script_name.sh delete username
```

This command removes the specified user's entry from /etc/ipsec.secrets.


## Script Details

- Arguments Check: The script first checks if exactly three arguments are provided.
- Action Handling: Depending on the action (add or delete), the script will either append a new user entry to the VPN secrets file or delete an existing one.
- Error Handling: If the provided action is not recognized, the script will display an error message and exit.

## Running the Script

1. Make the script executable:
```bash
chmod +x script_name.sh
```

2. Run the script with the required action and credentials:
```bash
sudo ./script_name.sh add|delete username [password]
```

## Important Notes

- The deletion process uses pattern matching to find the exact username in the secrets file, which means usernames should be unique to prevent accidental deletion of multiple entries.
- Ensure to manage the permissions of this script carefully, as it contains sensitive actions that modify VPN authentication settings.


## Limitations

- The script does not validate the format or strength of usernames or passwords.
- It assumes that the username does not contain special characters that could interfere with pattern matching in sed commands.
