import 'packages.pp'
import 'service.pp'
import 'cobbler.pp'
import 'config.pp'

class iptables (
	$running,
	$startup,
	$status
) {
	include 'iptables::packages'
	include 'iptables::service'
	include 'iptables::config'

	Class['iptables::packages'] -> Class['iptables::config'] -> Class['iptables::service']
}
