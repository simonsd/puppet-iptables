import 'packages.pp'
import 'service.pp'
import 'cobbler.pp'
import 'config.pp'

class iptables (
	$running = 'running',
	$startup = 'true',
	$status = 'present',
	$stages = 'no'
) {
	if $stages != 'yes' {
		class{
			'iptables::packages':
				before => Class['iptables::config'];
			'iptables::config':
				before => Class['iptables::service'];
			'iptables::service':;
		}
	} else {
		class {
			'iptables::packages':
				stage => depends;
			'iptables::config':
				stage => config;
			'iptables::service':
				stage => services;
		}
	}

	if $::operatingsystem == archlinux {
		Service {
			path => '/etc/rc.d'
		}
	}
}
