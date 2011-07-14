import 'packages.pp'
import 'service.pp'
import 'cobbler.pp'

class iptables {
	include 'iptables::packages.pp'
	include 'iptables::service.pp'
}
