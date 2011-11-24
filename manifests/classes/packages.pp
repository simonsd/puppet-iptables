class iptables::packages {
	package { "iptables":
		ensure => "$iptables::status",
	}
}
