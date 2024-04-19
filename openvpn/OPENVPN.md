# Comprehensive OpenVPN Installation Script

This Bash script automates the deployment of OpenVPN along with necessary configurations on a variety of Linux distributions including Debian, Ubuntu, Fedora, CentOS, Oracle Linux, Amazon Linux 2, and Arch Linux.

## Important

This script was not written by me, however, it is highly customizable and you can eject needed functionality.

## Features

- **Automatic Installation**: Installs and configures OpenVPN, Easy-RSA, and related packages.
- **Custom Configuration**: Allows for custom configurations including port, protocol, DNS, and encryption settings.
- **User Management**: Adds and revokes OpenVPN users.
- **Security Enhancements**: Sets up iptables rules, optional compression settings, and more for enhanced security.
- **DNS Configuration**: Integrates Unbound as a DNS resolver to prevent DNS leaks.
- **IPv6 Support**: Configures and manages IPv6 settings if enabled.

## Requirements

- The script must be run as root or with sudo privileges.
- TUN (network tunnel) must be enabled on the system.

## Usage

Before running the script, ensure you are logged in as root or are able to run commands with `sudo`. The script checks for prerequisites like TUN availability and the operating system.

### Running the Script

1. Download or transfer the script to your server.
2. Make the script executable:
```bash
chmod +x vpn_setup_script.sh
```
3. Execute the script:
```bash
sudo ./vpn_setup_script.sh
```

## Operations
- **Install OpenVPN**: Automatically performs installation and setup.
- **Add a New User**: Interactive option to add a new user with or without a password.
- **Revoke an Existing User**: Allows for the revocation of users.
- **Remove OpenVPN**: Uninstalls OpenVPN and associated configurations.

## Important Notes

- **IP Detection**: The script automatically detects public IPv4 or IPv6 addresses unless overridden.
- **Custom DNS Options**: Provides options for different DNS providers or self-hosted DNS via Unbound.
- **Security Settings**: Includes settings for different types of encryption and authentication methods based on user preferences.

##Script Actions Overview

- **Initial Checks**: Verifies if running as root, if TUN is available, and determines the OS.
- **Package Installation**: Installs necessary packages using the native package manager.
- **OpenVPN and Easy-RSA Setup**: Configures OpenVPN server settings, sets up Easy-RSA for certificate management.
- **Firewall Configuration**: Sets up iptables rules to manage traffic through the VPN.
- **Optional Unbound Installation**: For DNS resolution without leaks.
- **User Management**: Adds and revokes users via interactive prompts.
- **Clean Removal**: Provides an option to completely remove all configurations and packages related to OpenVPN.

##Customizing Installation

You can modify the script to adjust the default configurations like port, DNS settings, and more before running it.
