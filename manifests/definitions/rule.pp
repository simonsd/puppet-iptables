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
			command => "/sbin/iptables -I $chain -t $table -p $proto --dport $dport -j $jump",
			unless => "/sbin/iptables -L|grep $proto|grep $jump";

		"remove_iptables_rule_$name":
			command => "/sbin/iptables -D $chain -t $table -p $proto --dport $dport -j $jump";
#			onlyif => "/sbin/iptables -L|grep $proto|grep $dport|grep $jump";
	}

	case $ensure {
		present: { realize(Exec["add_iptables_rule_$name"]) }
		absent: { realize(Exec["remove_iptables_rule_$name"]) }
	}
}
