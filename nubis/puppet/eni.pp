
file { '/usr/local/bin/eni-associate':
    ensure => file,
    owner  => root,
    group  => root,
    mode   => '0744',
    source => 'puppet:///nubis/files/eni-associate',
}

file { '/etc/nubis.d/98-eni-associate':
    ensure  => link,
    target  => '/usr/local/bin/eni-associate',
    require => File['/usr/local/bin/eni-associate'],
}
