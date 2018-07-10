Plugin mac firewire ethernet

Open System Preferences / Network
- select the service
- rename to `eiab`

### Controll node (rpi)

-   sudo yum install dhcp tcpdump
-   systemctl restart dhcpd
-   sudo tcpdump -i enp0s8 port bootpc
-   sudo tcpdump port bootpc


### static IP

-   https://www.raspberrypi.org/documentation/hardware/raspberrypi/bootmodes/net_tutorial.md
-   ip route | grep default | awk '{print $3}'
-   ip -4 addr show dev eth1 | grep inet
-   https://www.ubuntu.com/download/server/provisioning
-   sudo nano /etc/network/interfaces
-   sudo systemctl disable dhcpcd
-   sudo systemctl enable networking
-   sudo reboot
-   echo "nameserver 169.254.255.1" | sudo tee -a /etc/resolv.conf

Configure a [DHCP](https://en.wikipedia.org/wiki/Dynamic_Host_Configuration_Protocol) server:

```
vi /etc/dhcp/dhcpd.conf
vi /etc/sysconfig/dhcpd
```


default-lease-time 600;
max-lease-time 7200;
subnet 10.0.0.0 netmask 255.255.255.0 {
	option subnet-mask 255.255.255.0;
	option routers 10.1.0.1;
	range 10.0.0.5 10.0.0.254;
}

https://tools.ietf.org/html/rfc1918

### Mac

-   netstat -nr -f inet
        -n Show network addresses as numbers
        -r Show the routing tables
        -f protocol
        169.254.*.* indicates your local DHCP server did not give you are IP address.
        https://tools.ietf.org/html/rfc3927
-   arp -a
        -a The program displays or deletes all of the current ARP entries
-   arp -a -i en5
        -a The program displays or deletes all of the current ARP entries
        -i interface
-   ifconfig
-   sudo route add 10.0.0.0/24 10.0.0.2

```
en5: flags=8863<UP,BROADCAST,SMART,RUNNING,SIMPLEX,MULTICAST> mtu 1500
	options=10b<RXCSUM,TXCSUM,VLAN_HWTAGGING,AV>
	ether 38:c9:86:3c:f8:99
	nd6 options=201<PERFORMNUD,DAD>
	media: autoselect (none)
	status: inactive
```

set manual config: https://itsecureadmin.com/2012/12/configure-mac-osx-network-interface-from-the-command-line/

-   networksetup -getinfo "eiab"
-   networksetup -setnetworkserviceenabled eiab off
-   networksetup -setnetworkserviceenabled eiab on
-   networksetup -setmanual eiab 10.0.0.3 255.255.255.0 10.0.0.2
-   networksetup -setv6off eiab


