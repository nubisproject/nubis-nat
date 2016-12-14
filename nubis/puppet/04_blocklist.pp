file { '/usr/local/bin/nubis-nat-vpc-blocklist':
  owner  => 'root',
  group  => 'root',
  mode   => '0755',
  source => 'puppet:///nubis/files/vpc-blocklist'
}

cron::job{ 'nubis-nat-vpc-blocklist':
  minute      => '*/15',
  hour        => '*',
  date        => '*',
  month       => '*',
  weekday     => '*',
  user        => 'root',
  command     => 'nubis-cron nubis-nat-vpc-blocklist /usr/local/bin/nubis-nat-vpc-blocklist',
  environment => [
    'PATH="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin"',
  ]
}
