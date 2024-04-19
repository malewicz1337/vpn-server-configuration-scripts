# WireGuard Setup Script

This Bash script automates the installation and management of a WireGuard VPN. It's designed for new and existing WireGuard setups, enabling the addition of clients, removal of clients, or complete uninstallation of WireGuard.

## Features

- **Installation**: Installs and configures WireGuard on supported Linux distributions.
- **Client Management**: Allows adding and removing VPN clients.
- **DNS Configuration**: Supports multiple DNS providers for clients.
- **Compatibility Checks**: Ensures compatibility with the hosting environment.

## Requirements

- The script must be run as root or with sudo privileges.
- The system must be running a compatible Linux distribution: Ubuntu (18.04 or later), Debian (10 or later), AlmaLinux, Rocky Linux, CentOS (7 or later), and Fedora.
- `curl` or `wget` should be installed.
- `qrencode` for generating QR codes that can be scanned to configure mobile clients.

## Usage

1. Make the script executablet:
```bash
chmod +x wireguard-install.sh
```
2. Run the script:
```bash
sudo ./wireguard-setup.sh
```

## Options
1. Add a new client: Generates a new client configuration with a QR code.
2. Remove an existing client: Removes a client from the VPN server.
3. Remove WireGuard: Uninstalls WireGuard and cleans up configuration files.
4. Exit: Closes the script.


The script also checks if the system is running inside a container, adjusts the configuration to work in a containerized environment, and provides detailed feedback on the required steps if WireGuard's kernel module isn't supported.

## Customization

You can customize DNS settings, WireGuard listening port, and the public IP address during the installation process.

## Additional Information

If running in a container, the script uses BoringTun to set up WireGuard. It supports auto-updates for BoringTun if enabled during installation.
