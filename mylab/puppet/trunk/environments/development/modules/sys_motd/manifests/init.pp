class sys_motd {
  file { '/etc/motd':
    ensure => file,
    source => 'puppet:///sys_motd/motd', 
  }
}
