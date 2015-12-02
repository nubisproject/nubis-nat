# Assumes this gets added from nubis_nat class
#file { '/usr/local/lib/util.sh':
#    ensure => file,
#    owner  => root,
#    group  => root,
#    mode   => '0644',
#    source => 'puppet:///nubis/files/util.sh'
#}

file { '/usr/local/bin/eni-associate':
    ensure  => file,
    owner   => root,
    group   => root,
    mode    => '0755',
    source  => 'puppet:///nubis/files/eni-associate',
    require => File['/usr/local/lib/util.sh']
}

#file { '/etc/nubis.d/98-eni-associate':
#    ensure  => link,
#    target  => '/usr/local/bin/eni-associate',
#    require => File['/usr/local/bin/eni-associate'],
#}

class { 'nubis_nat':
    nat_interface           => 'eth0',
    disable_route_interface => 'eth1',
}
