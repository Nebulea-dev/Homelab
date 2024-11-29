# Lea's home lab

This is the entry point for all documentation and various resources about my home lab.

## OpenVPN

The VPN server was setup using [this tutorial](https://www.baeldung.com/linux/vpn-server-setup). It's running on port 1194 and the subnet is `10.8.0.0/24`.
There is a script in `/home/ubuntu/openvpn` called `openvpn-install.sh`. It's used to add clients, and setup everything.
