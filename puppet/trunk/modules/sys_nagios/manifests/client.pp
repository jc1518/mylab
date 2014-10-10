class sys_nagios::client {

  $cfgpath = "/etc/nagios/conf.d"
 
#  package { 'nrpe':
#    ensure => installed,
#  }

#  service { 'nrpe':
#    ensure => running,
#    enable => true,
#    require => Package[nrpe]
#  }

  @@nagios_host { "$fqdn":
    ensure => present,
    alias => $fqdn,
    address => $ipaddress_eth1,
    use => "linux-server",
    hostgroups => "$environment, linux-servers",
    target => "$cfgpath/host_$fqdn.cfg",
  }

#  @@nagios_service { "check_ping_$fqdn":
#    check_command => "check_ping!100.0,20%!500.0,60%",
#    use => "generic-service",
#    host_name => "$fqdn",
#    target => "$cfgpath/service_check_ping_$fqdn.cfg",
#  }

#  @@nagios_service
    
}
