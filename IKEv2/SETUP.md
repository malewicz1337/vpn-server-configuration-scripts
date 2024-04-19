# IKEv2 VPN Setup Script for Ubuntu

This script automates the process of setting up a VPN on Ubuntu versions 18.04, 20.04, and 22.04. It configures StrongSwan, IPsec, firewall rules, and various other system settings to support VPN functionality.

## Important
This script was not written entirely by me

## Requirements

- The script is intended for Ubuntu versions 18.04, 20.04, and 22.04 only.
- It must be run with root privileges.

## Features

- Sets up a VPN using StrongSwan.
- Configures IPsec with robust security settings.
- Sets network firewall rules for secure VPN operation.
- Manages DNS settings and uses popular DNS servers for resolution.
- Configures system settings like IP forwarding and packet fragmentation handling.
- Installs and configures necessary packages for VPN and system security.
- Handles RSA certificates for authentication.
- Sets up system users and SSH configurations.
- Automatically handles system updates and security patches.

## How to Use

1. Ensure you are running one of the supported Ubuntu versions: 18.04, 20.04, or 22.04.
2. Download the script to your server.
3. Make the script executable:
```bash
chmod +x path_to_script.sh
```
4. Run the script as root or with sudo:
```bash
sudo ./path_to_script.sh
```


## Caution

- Running this script will make significant changes to system configurations including network settings, security policies, and user permissions.
- It is highly recommended to review the script thoroughly before running it, and ensure that backups of important data and configuration files are made.

## Script Actions Overview

- **Checks Ubuntu version**: The script starts by verifying that it's being run on a compatible Ubuntu version.
- **Requires root privileges**: Ensures the script is run with root permissions to make system-wide changes.
- **Installs required packages**: Various necessary packages are installed, including `strongswan` for VPN, `iptables-persistent` for firewall configurations, and `certbot` for handling Let's Encrypt certificates.
- **Configures network settings**: Sets up IP forwarding, masquerading, and firewall rules tailored for VPN use.
- **Sets up VPN configurations**: Configures IPsec and StrongSwan settings, and creates VPN user credentials.
- **Handles SSH configurations**: Adjusts SSH server settings to enhance security, such as disabling root login and setting up SSH keys.
- **System maintenance**: Configures automatic updates and handles timezone and locale settings.

## Additional Information

For more detailed information about the specific configurations applied by the script, you may refer to the inline comments within the script itself. These comments provide context and rationale for the configuration choices made.
