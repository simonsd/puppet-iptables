class iptables::cobbler {
	exec { "iptables":
		path => "/sbin/",
		command => "iptables -A INPUT -m state --state NEW -m tcp -p tcp --dport 69 -j ACCEPT;iptables -A INPUT -m state --state NEW -m udp -p udp --dport 69 -j ACCEPT;iptables -A INPUT -m state --state NEW -m tcp -p tcp --dport 80 -j ACCEPT;iptables -A INPUT -m state --state NEW -m tcp -p tcp --dport 443 -j ACCEPT;iptables -A INPUT -m state --state NEW -m tcp -p tcp --dport 25151 -j ACCEPT;iptables-save;touch /etc/puppet/iptables",
		unless => "ls /etc/cobbler/iptables",
	}
}
