class iptables::service {
	service {
		'iptables':
			ensure => "$iptables::running",
			enable => "$iptables::startup",
			path => $::operatingsystem ? {
				default => undef,
				archlinux => '/etc/rc.d',
			};
	}
}
