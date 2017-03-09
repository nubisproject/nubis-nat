class { 'fluentd':
  service_ensure => stopped
}

fluentd::configfile { 'squid': }

fluentd::source { 'squid_access':
  configfile  => 'squid',
  type        => 'tail',
  time_format => '%s.%L',
  format      => '/^(?<time>(\d+\.\d+))\s+(?<duration>(\d+))\s+(?<client>([^ ]*))\s+(?<cache>([A-Z_]*))/(?<status>(\d+))\s+(?<bytes>(\d+))\s+(?<method>([A-Z]+))\s+(?<url>([^ ]*))\s+(?<user>([^ ]*))\s+(?<hierarchy_type>([A-Z_]+))/(?<hierarchy_target>([^ ]+))\s+(?<content_type>([^ ]*))$/',
  tag         => 'forward.squid.access',

  config      => {
    'path' => "/var/log/${::squid3::params::service_name}/access.log",
  },
}

fluentd::source { 'squid_cache':
  configfile => 'squid',
  type       => 'tail',
  format     => 'none',
  tag        => 'forward.squid.cache',
  config     => {
    'path' => "/var/log/${::squid3::params::service_name}/cache.log",
  },
}

fluentd::source { 'squid_store':
  configfile => 'squid',
  type       => 'tail',
  format     => 'none',
  tag        => 'forward.squid.store',
  config     => {
    'path' => "/var/log/${::squid3::params::service_name}/store.log",
  },
}

fluentd::configfile { 'iptables': }

fluentd::source { 'iptables':
    configfile  => 'iptables',
    type        => 'tail',
    time_format => '%b %d %H:%M:%S',

    # Incomplete format, missing various fields TOS, PREC, TTL, ID, etc, but most importantly
    # TODO: it's missing the ACK/SYN/FIN flags
    format      => '/^(?<time>(\S+\s+\S+\s+\S+)).*\[(?<iptables_chain>(\S+))\]\s+IN=(?<iptables_in>(\S*))\s+OUT=(?<iptables_out>(\S*))\s+MAC=(?<iptables_mac>([0-9a-f:]+))\s+SRC=(?<iptables_src>(\S*))\s+DST=(?<iptables_dst>(\S*))\s+LEN=(?<iptables_len>(\d+))\s+.* PROTO=(?<iptables_proto>(\S+))\s+SPT=(?<iptables_source_port>(\S*))\s+DPT=(?<iptables_destination_port>(\S*))/',

    tag         => 'forward.iptables',
    config      => {
        'path' => '/var/log/iptables.log',
    },
}
