file { '/etc/sysconfig/iptables.save':
    ensure => file,
    owner  => root,
    group  => root,
    mode   => '0644',
    source => 'puppet:///nubis/files/nat/iptables.save',
}

file { '/etc/profile.d/proxy.sh':
    ensure => file,
    owner  => root,
    group  => root,
    mode   => '0644',
    source => 'puppet:///nubis/files/nat/profile.d_proxy.sh',
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
    ensure => file,
    owner  => root,
    group  => root,
    mode   => '0755',
    source => 'puppet:///nubis/files/nat/eni-associate',
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

file { '/etc/nubis.d/conntrackd-onboot':
    ensure => file,
    owner  => root,
    group  => root,
    mode   => '0755',
    source => 'puppet:///nubis/files/conntrackd-onboot',
}

# TODO: Should have a proper fix and not have nsm class
# install supervisor
#class { 'nsm':
#    nsm_mailto  => 'moc@mozilla.com'
#}->

package { 'epel-release':
  ensure => latest,
}->
yumrepo { 'epel':
  enabled => 1,
}

yumrepo { 'ec2-net-utils':
  descr    => 'Copr repo for ec2-net-utils',
  baseurl  => 'https://copr-be.cloud.fedoraproject.org/results/gozer/ec2-utils/epel-7-$basearch/',
  enabled  => 1,
  gpgcheck => 1,
  gpgkey   => 'https://copr-be.cloud.fedoraproject.org/results/gozer/ec2-utils/pubkey.gpg',
}

package { 'ec2-net-utils':
  ensure  => latest,
  require => [
    Yumrepo['ec2-net-utils'],
    Yumrepo['epel'],
  ]
}->
service { 'elastic-network-interfaces':
  enable => true,
}

package { 'supervisor':
  ensure  => latest,
  require => [
    Package['epel-release'],
  ]
}

service {'supervisord':
  enable  => true,
  require => [
    Package['supervisor'],
  ],
}

# Workaround for nubis_nat using hard-coded /usr/local/bin path
file { '/usr/local/bin/supervisord':
  ensure  => link,
  target  => '/usr/bin/supervisord',
  require => [
    Package['supervisor'],
  ]
}

class { 'nubis_nat':
    startup_order     => '0-3',
    nat_in_interface  => 'eth1',
    nat_out_interface => 'eth0',
    require           => [
      File['/usr/local/bin/supervisord'],
      Package['supervisor'],
    ],
}
