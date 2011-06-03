class iptables::packages {
	package { "iptables":
		ensure => installed,
	}
}
