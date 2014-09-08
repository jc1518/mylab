class sys_puppet::puppet_node_conf {

  if $hostname =~ /^dev/ {
    notice("dev box")
    $conf_file = "puppet-node-dev" 
  }
  elsif $hostname == 'puppet' {
    notice("puppet master")
    $conf_file = "puppet-master-conf"
  }
  else {
    notice("prod box")
    $conf_file = "puppet-node-prod"
  }

  file {'/etc/puppet/puppet.conf':
    ensure => file,
    source => "puppet:///modules/sys_puppet/$conf_file",
  }


}
