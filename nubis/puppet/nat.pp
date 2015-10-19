
file { '/usr/local/lib/util.sh':
    ensure => file,
    owner  => root,
    group  => root,
    mode   => '0644',
    source => 'puppet:///nubis/files/util.sh'
}

file { '/usr/local/bin/nat.sh':
    ensure  => file,
    owner   => root,
    group   => root,
    mode    => '0755',
    source  => 'puppet:///nubis/files/nat.sh',
    require => File['/usr/local/lib/util.sh']
}

