class sys_cron::push_facts {

  cron { puppet_push_facts:
    ensure => present,
    command => "/etc/puppet/push_facts.rb",
    user => root,
    minute => '*/5',
  }

}
