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

# Make sure its not running during packer build
# we start this up after our eni starts up
# startup will happen in nubis.d
service { 'squid-exporter':
  ensure => 'stopped',
  enable => false,
}

case $::osfamily {
  'RedHat': {
    file { '/etc/init.d/squid-exporter':
      ensure => file,
      owner  => root,
      group  => root,
      mode   => '0755',
      source => 'puppet:///nubis/files/squid-exporter/squid-exporter.init',
      before =>  Service['squid-exporter'],
    }
  }
  'Debian': {
    file { '/etc/init/squid-exporter.conf':
      ensure => file,
      owner  => root,
      group  => root,
      mode   => '0644',
      source => 'puppet:///nubis/files/squid-exporter/squid-exporter.upstart',
      before =>  Service['squid-exporter'],
    }
    file { '/etc/init/squid-exporter.override':
      ensure  => file,
      owner   => root,
      group   => root,
      mode    => '0644',
      content => 'manual',
      before  => Service['squid-exporter'],
    }
  }
  default: {
    fail("Unsupported OS for squid-exporter ${::osfamily}")
  }
}

file { '/etc/consul/svc-squid-exporter.json':
  ensure => file,
  owner  => root,
  group  => root,
  mode   => '0644',
  source =>  'puppet:///nubis/files/squid-exporter/svc-squid-exporter.json',
}

file { '/etc/nubis.d/99-squid-exporter-startup':
  ensure => file,
  owner  => root,
  group  => root,
  mode   => '0755',
  source =>  'puppet:///nubis/files/squid-exporter/99-squid-exporter-startup',
}
