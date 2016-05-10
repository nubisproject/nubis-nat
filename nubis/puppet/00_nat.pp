file { '/etc/sysconfig/iptables.save':
    ensure => file,
    owner  => root,
    group  => root,
    mode   => '0644',
    source => 'puppet:///nubis/files/nat/iptables.save',
}

file { '/etc/profile.d/proxy.sh':
    ensure  => file,
    owner   => root,
    group   => root,
    mode    => '0644',
    source  => 'puppet:///nubis/files/nat/profile.d_proxy.sh',
}

file { '/etc/rsyslog.d/99-iptables.conf':
    ensure => file,
    owner  => root,
    group  => root,
    mode   => '0644',
    source => 'puppet:///nubis/files/nat/logging/99-iptables.conf',
}

file { '/etc/logrotate.d/iptables':
    ensure => file,
    owner  => root,
    group  => root,
    mode   => '0644',
    source => 'puppet:///nubis/files/nat/logging/logrotate_iptables.conf',
}

file { '/etc/confd/conf.d/iptables.toml':
    ensure => file,
    owner  => root,
    group  => root,
    mode   => '0644',
    source => 'puppet:///nubis/files/nat/confd/conf.d/iptables.toml'
}

file { '/etc/confd/templates/iptables.tmpl':
    ensure => file,
    owner  => root,
    group  => root,
    mode   => '0644',
    source => 'puppet:///nubis/files/nat/confd/templates/iptables.tmpl',
}

file { '/usr/local/bin/eni-associate':
    ensure  => file,
    owner   => root,
    group   => root,
    mode    => '0755',
    source  => 'puppet:///nubis/files/nat/eni-associate',
}

# This needs to happen before nat is configured
file { '/etc/nubis.d/0-0-eni-associate':
    ensure  => link,
    target  => '/usr/local/bin/eni-associate',
    require => File['/usr/local/bin/eni-associate'],
}

# This is 001 on purpose it needs to run before consul
file { '/etc/nubis.d/0-1-interface-fixup':
    ensure => file,
    owner  => root,
    group  => root,
    mode   => '0755',
    source => 'puppet:///nubis/files/interface-fixup',
}

# TODO: Should have a proper fix and not have nsm class
# install supervisor
class { 'nsm':
    nsm_mailto  => 'infosec@mozilla.com'
}->
class { 'nubis_nat':
    startup_order     => '0-3',
    nat_in_interface  => 'eth1',
    nat_out_interface => 'eth0',
}
