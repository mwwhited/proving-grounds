
# Enable IP Forwarding
echo 1 > /proc/sys/net/ipv4/ip_forward

# NAT out USB0 (NeTV)
 /sbin/iptables -t nat -A POSTROUTING -o usb0 -j MASQUERADE

# Enable Stateful filter/forward
/sbin/iptables -A FORWARD -i eth0 -o usb0 -m state --state RELATED,ESTABLISHED -j ACCEPT
/sbin/iptables -A FORWARD -i usb0 -o eth0 -j ACCEPT