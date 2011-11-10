define iptables::rule (
	$ensure = 'present',
	$table = 'filter',
	$chain = 'INPUT',
	$proto = 'tcp',
	$dport,
	$jump = 'ACCEPT'
) {
	@exec {
		"add_iptables_rule_$name":
			command => "iptables -I $chain -t $table -p $proto --dport $dport -j $jump";

		"remove_iptables_rule_$name":
			command => "iptables -D $chain -t $table -p $proto --dport $dport -j $jump";
	}

	case $ensure {
		present: { realize(Exec["add_iptables_rule_$name"]) }
		absent: { realize(Exec["remove_iptables_rule_$name"]) }
	}
}
