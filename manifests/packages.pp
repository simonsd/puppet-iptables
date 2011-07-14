class iptables::packages {
	package { "iptables":
		ensure => "$iptables_status",
	}
}
