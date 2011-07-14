class iptables::service {
	service { "iptables":
		ensure => "$iptables_running",
		enable => "$iptables_startup",
	}
}
