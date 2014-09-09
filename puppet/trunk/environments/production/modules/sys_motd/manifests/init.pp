class sys_motd {
  file { '/etc/motd':
    ensure => file,
    content => template('sys_motd/motd.erb'),
  }
}
