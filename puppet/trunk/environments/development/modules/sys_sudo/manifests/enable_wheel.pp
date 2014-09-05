class sys_sudo::enable_wheel {

  file_line { 'enable_wheel':
    path => '/etc/sudoers',
    line => '%wheel	ALL=(ALL)	NOPASSWD: ALL',
    match => '.*%wheel.*NOPASSWD: .*$',
  }

}
