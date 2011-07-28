class iptables::service {
	service { "iptables":
		ensure => "$iptables::running",
		enable => "$iptables::startup",
	}
}
