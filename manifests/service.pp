class iptables::service {
	service { "iptables":
		ensure => running,
		enable => true,
	}
}
