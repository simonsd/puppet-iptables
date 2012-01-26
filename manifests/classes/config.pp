class iptables::config {
  @file {
    'iptables_initscript':
      path => '/etc/init.d/iptables',
      ensure => present,
      owner => root,
      group => root,
      mode => 0755,
      content => template('iptables/iptables.init.erb');
  }

  if $::operatingsystem == 'debian' {
    realize(File['iptables_initscript'])
  }

  exec {
    'save_iptables_rules':
      command => "iptables-save > ${iptables::savefile}",
      path => '/sbin:/usr/sbin',
      refreshonly => true;
  }
}
