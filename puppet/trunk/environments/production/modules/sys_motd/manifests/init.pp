class sys_motd {
  file { '/etc/motd':
    ensure => file,
    source => 'puppet:///modules/sys_motd/motd', 
  }
}
