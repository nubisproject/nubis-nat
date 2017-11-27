package { 'conntrack-tools':
  ensure => latest,
}->
service { 'conntrackd':
  enable => false
}

# Enable consul-template, base doesn't enable it yet
class { 'consul_template':
    service_enable => true,
    service_ensure => 'stopped',
    version        => '0.16.0',
    user           => 'root',
    group          => 'root',
}

# Drop our template
file { "${consul_template::config_dir}/conntrackd.conf.ctmpl":
  ensure  => file,
  owner   => root,
  group   => root,
  mode    => '0644',
  source  => 'puppet:///nubis/files/conntrackd.conf.ctmpl',
  require => [
    Class['consul_template'],
  ],
}

# Configure our navigation links
consul_template::watch { 'conntrackd.conf':
    source      => "${consul_template::config_dir}/conntrackd.conf.ctmpl",
    destination => '/etc/conntrackd/conntrackd.conf',
    command     => '/usr/bin/systemctl restart conntrackd',
}
