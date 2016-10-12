# Configuring general stuff

file { '/etc/update-motd.d/55-squid-welcome':
  source => 'puppet:///nubis/files/nat-welcome',
  owner  => 'root',
  group  => 'root',
  mode   => '0755',
}

exec { 'motd_update':
  command => $motd_update_command,
  require => File['/etc/update-motd.d/55-squid-welcome'],
}
