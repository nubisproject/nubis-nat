$squid_exporter_version = '0.1'
$squid_exporter_url     = "https://github.com/boynux/squid-exporter/releases/download/v${squid_exporter_version}/squid-exporter"

notice("Grabbing squid_exporter v${squid_exporter_version}")

staging::file { '/usr/local/bin/squid-exporter':
  source => $squid_exporter_url,
  target =>  '/usr/local/bin/squid-exporter',
} ->
exec { 'chmod /usr/local/bin/squid-exporter':
  command => 'chmod 755 /usr/local/bin/squid-exporter',
  path    =>  ['/sbin','/bin','/usr/sbin','/usr/bin','/usr/local/sbin','/usr/local/bin'],
}

case $::osfamily {
  'RedHat': {
    file { '/etc/init.d/squid_exporter':
      ensure => file,
      owner  => root,
      group  => root,
      mode   => '0755',
      source => 'puppet:///nubis/files/squid-exporter/squid-exporter.init',
    }->
    service { 'squid_exporter':
      enable => true,
    }
  }
  'Debian': {
    file { '/etc/init/squid-exporter.conf':
      ensure => file,
      owner  => root,
      group  => root,
      mode   => '0644',
      source => 'puppet:///nubis/files/squid-exporter/squid-exporter.upstart',
    }
    file { '/etc/init/squid-exporter.override':
      ensure  => file,
      owner   => root,
      group   => root,
      mode    => '0644',
      content => 'manual',
    }
  }
  default: {
    fail("Unsupported OS for squid-exporter ${::osfamily}")
  }
}
