class sys_ldap {
  
  package { 'openldap':
    ensure => installed,
  }  

  package { 'openldap-clients':
    ensure => installed,
    require => Package['openldap']
  }
  
  package { 'sssd':
    ensure => installed,
  }

  file { '/etc/openldap/ldap.conf':
    ensure => file,
    source => 'puppet:///sys_ldap/ldap.conf',
    require => Package['openldap-clients'],
  }

  file { '/etc/openldap/certs/ldap-pub.pem':
     ensure => file,
     source => 'puppet:///sys_ldap/ldap-pub.pem',
     require => Package['openldap-clients'],
  }

  file { '/etc/sssd/sssd.conf':
    ensure => file,
    source => 'puppet:///sys_ldap/sssd.conf',
    mode => 600,
    require => Package['sssd'],
  }

  exec { '/usr/sbin/authconfig --enablesssd --enablesssdauth --enableldap --enableldapauth --enablemkhomedir --ldapserver=ldaps://ldap.mylab.local --ldapbasedn=dc=mylab,dc=local --enablelocauthorize --enableldaptls --update':
    refreshonly => true,
    require => [ File['/etc/openldap/ldap.conf'], File['/etc/openldap/certs/ldap-pub.pem'], File['/etc/sssd/sssd.conf'], ],
  }

}
