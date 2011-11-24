import 'packages.pp'
import 'service.pp'
import 'cobbler.pp'
import 'config.pp'
import 'definitions/*.pp'

class iptables (
	$running = 'running',
	$startup = 'true',
	$status = 'present',
	$savefile = $::operatingsystem ? {
		default => '/etc/sysconfig/iptables',
		archlinux => '/etc/iptables/iptables.rules',
	}
){
	class {
		'iptables::packages':
			before => Class['iptables::config'];
		'iptables::config':
			before => Class['iptables::service'];
		'iptables::service':;
	}

	if $::operatingsystem == archlinux {
		Service {
			path => '/etc/rc.d'
		}
	}
}
