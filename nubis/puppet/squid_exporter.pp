$squid_exporter_version = '0.2'
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

systemd::unit_file { 'squid-exporter.service':
  source => 'puppet:///nubis/files/squid-exporter.systemd',
}->
service { 'squid-exporter':
  enable => true,
}

file { '/etc/consul/svc-squid-exporter.json':
  ensure => file,
  owner  => root,
  group  => root,
  mode   => '0644',
  source =>  'puppet:///nubis/files/squid-exporter/svc-squid-exporter.json',
}
