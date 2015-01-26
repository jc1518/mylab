class sys_yumversionlock {

  $yumlock = $operatingsystemrelease ? {
    /^5\./ => yum-versionlock,
    /^6\./ => yum-plugin-versionlock
  }

  package { $yumlock:
    ensure => installed,
    alias  => yum-versionlock
  }

  file { '/usr/local/sbin/create_locklist.sh':
    mode   => '0700',
    owner  => root,
    group  => root,
    source => 'puppet:///modules/sys_yumversionlock/create_locklist.sh'
   }

  exec { '/usr/local/sbin/create_locklist.sh':
    require     => [ Package['yum-versionlock'], File['/usr/local/sbin/create_locklist.sh'] ],
  }

  augeas { 'allow-yum-plugin':
    context => '/files/etc/yum.conf',
    changes => 'set main/plugins 1'
  }

  augeas { 'enable-versionlock':
    context => '/file/etc/yum/pluginconf.d/versionlock.conf',
    changes => 'set main/enabled 1',
    require => Package['yum-versionlock']
  }

}

