# WireGuard Management Script

This Bash script is designed to facilitate the management of WireGuard VPN peers on a Linux server. It automates the addition, deletion, and listing of VPN peers, and can also display peer configurations.

## Features

- **Add New Peers**: Automatically generates VPN configurations for new peers.
- **Delete Existing Peers**: Safely removes peers from the WireGuard configuration.
- **List All Peers**: Displays all configured peers.
- **Show Peer Configurations**: Outputs the configuration and QR code for easy scanning with mobile devices.

## Requirements

- The script must be run as root or with sudo privileges.
- **jq** and **curl** must be installed on the system to handle JSON data and fetch public IP addresses, respectively.
- WireGuard must be installed and configured on the server.

## Usage

1. Ensure you have root privileges:
```bash
sudo su
```

2. Make the script executable:
```bash
chmod +x wg_manage.sh
```

3. Run the script with the desired option:
```bash
sudo ./wg_manage.sh [option]
```

## Script Options
- **add <user_id>**: Adds a new peer with a specific user identifier.
- **show <public_key>**: Displays the configuration for a specific peer by their public key.
- **del <public_key>**: Removes a peer by their public key.
- **list**: Lists all peers.

## Important Notes

- The script checks for the presence of jq and curl and exits if they are not found. Ensure these utilities are installed before running the script.
- The script should be placed in a directory that is included in the system's PATH, or it should be run with its full path to avoid errors.

##Customization

- The script uses predefined variables like CFOLDER for the client configuration directory. These can be customized as needed.
- Peer IP allocation and DNS configuration are dynamically determined; manual adjustments may be necessary based on your specific network setup.
