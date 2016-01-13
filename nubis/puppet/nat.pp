file { '/usr/local/bin/eni-associate':
    ensure  => file,
    owner   => root,
    group   => root,
    mode    => '0755',
    source  => 'puppet:///nubis/files/eni-associate',
    require => File['/usr/local/lib/util.sh']
}

# This needs to happen before nat is configured
file { '/etc/nubis.d/98-eni-associate':
    ensure  => link,
    target  => '/usr/local/bin/eni-associate',
    require => File['/usr/local/bin/eni-associate'],
}

class { 'nubis_nat':
    nat_in_interface  => 'eth1',
    nat_out_interface => 'eth0',
}
