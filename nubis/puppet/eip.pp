file { '/usr/local/bin/eip-attach':
    ensure => file,
    owner  => root,
    mode   => root,
    mode   => '0755',
    source => 'puppet:///nubis/files/eip-attach',
}

file { '/etc/nubis.d/99-eip-attach':
    ensure  => link,
    target  => '/usr/local/bin/eip-attach',
    require => File['/usr/local/bin/eip-attach'],
}
