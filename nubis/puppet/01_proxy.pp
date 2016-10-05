# Configuring general stuff

exec { 'package_manager_update':
  command => $package_manager_update_command,
  returns => [ '0', '100' ],
}

package { 'makepasswd_package':
  ensure  => $makepasswd_package_version,
  name    => $makepasswd_package_name,
  require => Exec['package_manager_update'],
}

package { 'git_package':
  ensure  => $git_package_version,
  name    => $git_package_name,
  require => Exec['package_manager_update'],
}

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
