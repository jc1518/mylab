class sys_nagios::server {
  
  $cfgpath = "/etc/nagios/conf.d"
    
  package { [
    'nagios',
    'nagios-plugins-all',
    'nagios-plugins-nrpe'
    ]:
    ensure => installed,
  }

#  file { 'nagios':
#    ensure => present,
#    path => "/etc/nagios/nagios.cfg",
#    mode => 664,
#    source => "puppet:///modules/sys_nagios/nagios.cfg", 
#  }
 
  service { 'nagios':
    ensure => running,
    enable => true,
    hasrestart => true,
    hasstatus => true,
#    require => [ Package[nagios], File[nagios] ]
    require => Package[nagios],
  }


###### hostgroup starts ######

  @@nagios_hostgroup { 'production':
    ensure => present,
    alias => production,
    target => "$cfgpath/hostgroups.cfg"
  }

  @@nagios_hostgroup { 'development':
    ensure => present,
    alias => development,
    target => "$cfgpath/hostgroups.cfg"
  }

###### hostgroup ends ######

###### commands starts ######

###### commands ends ######

###### servicegroup starts ######

  @@nagios_servicegroup { 'infrastructure':
    ensure => present,
    alias => infrastructure,
    target => "$cfgpath/servicegroups.cfg"
  }

###### servicegroup ends ######

###### infrastructure services start ######

  @@nagios_service { "check_ping_infrastructure":
    check_command => "check_ping!5.0,2%!10.0,10%",
    use => "generic-service",
    service_description => "check ping",
    hostgroup_name => "production,development",
    servicegroups => "infrastructure", 
    target => "$cfgpath/service_check_infrastructure.cfg",
  }

  @@nagios_service { "check_ssh_infrastructure":
    check_command => "check_ssh",
    use => "generic-service",
    service_description => "check ssh",
    hostgroup_name => "production,development",
    servicegroups => "infrastructure",
    target => "$cfgpath/service_check_infrastructure.cfg",
  }

###### infrastructure services end ######

###### collect starts ######

  Nagios_host <<||>> {
    notify => [ Exec[cfg_chmod], Service[nagios] ]

  }

  Nagios_service <<||>> {
    notify => [ Exec[cfg_chmod], Service[nagios] ]
  }

  Nagios_command <<||>> {
    notify => [ Exec[cfg_chmod], Service[nagios] ]
  }

  Nagios_hostgroup <<||>> {
    notify => [ Exec[cfg_chmod], Service[nagios] ]
  }

  Nagios_servicegroup <<||>> {
    notify => [ Exec[cfg_chmod], Service[nagios] ]
  }

###### collect ends ######


  exec { 'cfg_chmod':
    command => "/bin/chmod 664 $cfgpath/*",
  }


}

