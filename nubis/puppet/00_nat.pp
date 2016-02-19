file { '/usr/local/bin/eni-associate':
    ensure  => file,
    owner   => root,
    group   => root,
    mode    => '0755',
    source  => 'puppet:///nubis/files/nat/eni-associate',
}

# This needs to happen before nat is configured
file { '/etc/nubis.d/98-eni-associate':
    ensure  => link,
    target  => '/usr/local/bin/eni-associate',
    require => File['/usr/local/bin/eni-associate'],
}

# This is 000 on purpose it needs to run before consul
file { '/etc/nubis.d/000-interface-fixup':
    ensure => file,
    owner  => root,
    group  => root,
    mode   => '0755',
    source => 'puppet:///nubis/files/interface-fixup',
}

class { 'nubis_nat':
    nat_in_interface  => 'eth1',
    nat_out_interface => 'eth0',
}

class { 'nsm':
    nsm_mailto  => 'michal@mozilla.com'
}
