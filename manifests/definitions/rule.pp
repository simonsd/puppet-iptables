define iptables::rule (
  $ensure = 'present',
  $table = 'filter',
  $chain = 'INPUT',
  $proto = 'tcp',
  $source = '0/0',
  $destination = '0/0',
  $dport,
  $jump = 'ACCEPT'
) {
  Exec {
    path => '/bin:/sbin:/usr/sbin'
  }

  @exec {
    "add_iptables_rule_$name":
      command => "iptables -I $chain -t $table -p $proto --dport $dport -d $destination -s $source -j $jump",
      unless => "iptables -L -n|grep $proto|grep $dport|grep $jump|grep $source|grep $destination",
      notify => Exec['save_iptables_rules'];

    "remove_iptables_rule_$name":
      command => "iptables -D $chain -t $table -p $proto --dport $dport -d $destination -s $source -j $jump",
      onlyif => "iptables -L -n|grep $proto|grep $dport|grep $jump|grep $source|grep $destination",
      notify => Exec['save_iptables_rules'];
  }

  case $ensure {
    present: { realize(Exec["add_iptables_rule_$name"]) }
    absent: { realize(Exec["remove_iptables_rule_$name"]) }
  }
}
