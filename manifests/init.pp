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
		class{'iptables::packages':} -> class{'iptables::config':} -> class{'iptables::service':}
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
}
