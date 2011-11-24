define iptables::rule (
	$ensure = 'present',
	$table = 'filter',
	$chain = 'INPUT',
	$proto = 'tcp',
	$dport,
	$jump = 'ACCEPT'
) {
	Exec {
		path => '/bin:/sbin:/usr/sbin'
	}

	@exec {
		"add_iptables_rule_$name":
			command => "iptables -I $chain -t $table -p $proto --dport $dport -j $jump",
			unless => "iptables -L -n|grep $proto|grep $dport|grep $jump",
			notify => Exec['save_iptables_rules'];

		"remove_iptables_rule_$name":
			command => "iptables -D $chain -t $table -p $proto --dport $dport -j $jump",
			onlyif => "iptables -L -n|grep $proto|grep $dport|grep $jump",
			notify => Exec['save_iptables_rules'];
	}

	exec {
		'save_iptables_rules':
			command => "iptables-save > ${iptables::savefile}",
			refreshonly => true;
	}

	case $ensure {
		present: { realize(Exec["add_iptables_rule_$name"]) }
		absent: { realize(Exec["remove_iptables_rule_$name"]) }
	}
}
