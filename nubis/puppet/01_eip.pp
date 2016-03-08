file { '/usr/local/bin/eip-attach':
    ensure => file,
    owner  => root,
    group  => root,
    mode   => '0755',
    source => 'puppet:///nubis/files/nat/eip-attach',
}

file { '/etc/nubis.d/0-2-eip-attach':
    ensure  => link,
    target  => '/usr/local/bin/eip-attach',
    require => File['/usr/local/bin/eip-attach'],
}
