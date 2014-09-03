define sys_key::copy_key ($user) {
  
  file { "/home/$user/":
    ensure => directory,
    owner => $user,
    #group => $user,
    mode => 700,
    replace => false,
  }

  file { "/home/$user/.ssh":
    ensure => directory,
    owner => $user,
    #group => $user,
    mode => 700,
  }

  file { "/home/$user/.bash_profile":
    ensure => present,
    owner => $user,
    #group => $user,
    source => "puppet:///sys_key/.bash_profile",
  }

  file { "/home/$user/.bashrc":
    ensure => present,
    owner => $user,
    #group => $user,
    source => "puppet:///sys_key/.bashrc",
  }

  file { "/home/$user/.ssh/authorized_keys":
    ensure => present,
    owner => $user,
    #group => $user,
    mode => 600,
    source => "puppet:///sys_key/$user.pub",
    require => File["/home/$user/.ssh"],
  }

}
