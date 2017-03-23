$snmp_exporter_version = '0.1.0'
$snmp_exporter_url = "https://github.com/prometheus/snmp_exporter/releases/download/v${snmp_exporter_version}/snmp_exporter-${snmp_exporter_version}.linux-amd64.tar.gz"

notice ("Grabbing snmp_exporter ${snmp_exporter_version}")
staging::file { "snmp_exporter.${snmp_exporter_version}.tar.gz":
  source => $snmp_exporter_url,
}->
staging::extract { "snmp_exporter.${snmp_exporter_version}.tar.gz":
  target  => '/usr/local/bin',
  strip   => 1,
  creates => '/usr/local/bin/snmp_exporter',
}

# make sure the services are disabled on boot, confd starts conditionnally later
case $::osfamily {
  'RedHat': {
    file { '/etc/init.d/snmp_exporter':
      ensure => file,
      owner  => root,
      group  => root,
      mode   => '0755',
      source => 'puppet:///nubis/files/snmp_exporter/snmp_exporter.init',
    }->
    service { 'snmp_exporter':
      enable => false,
    }
  }
  'Debian': {
    file { '/etc/init/snmp_exporter.conf':
      ensure => file,
      owner  => root,
      group  => root,
      mode   => '0644',
      source => 'puppet:///nubis/files/snmp_exporter/snmp_exporter.upstart',
    }
    file { '/etc/init/snmp_exporter.override':
      ensure  => file,
      owner   => root,
      group   => root,
      mode    => '0644',
      content => 'manual',
    }
  }
  default: {
    fail("Unsupported OS for snmp_exporter ${::osfamily}")
  }
}

file { '/etc/snmp_exporter.yml':
  ensure => file,
  owner  => root,
  group  => root,
  mode   => '0644',
  source => 'puppet:///nubis/files/snmp_exporter/config.yml',
}

file { '/etc/consul/svc-snmp-exporter.json':
  ensure => file,
  owner  => root,
  group  => root,
  mode   => '0644',
  source => 'puppet:///nubis/files/snmp_exporter/svc-snmp-exporter.json',
}

file { '/etc/confd/conf.d/snmp_exporter.toml':
    ensure => file,
    owner  => root,
    group  => root,
    mode   => '0644',
    source => 'puppet:///nubis/files/snmp_exporter/confd/conf.d/snmp_exporter.toml'
}

file { '/etc/confd/templates/snmp_exporter.tmpl':
    ensure => file,
    owner  => root,
    group  => root,
    mode   => '0644',
    source => 'puppet:///nubis/files/snmp_exporter/confd/templates/snmp_exporter.tmpl',
}

