class { 'fluentd':
  service_ensure => stopped
}

fluentd::configfile { 'squid': }

fluentd::source { 'squid_access':
  configfile => 'squid',
  type       => 'tail',
  time_format => '%s',
  format     => '/^(?<time>(\d+))\.\d+\s+(?<duration>(\d+))\s+(?<client>([^ ]*))\s+(?<cache>([A-Z_]*))/(?<status>(\d+))\s+(?<bytes>(\d+))\s+(?<method>([A-Z]+))\s+(?<url>([^ ]*))\s+(?<user>([^ ]*))\s+(?<hierarchy_type>([A-Z_]+))/(?<hierarchy_target>([^ ]+))\s+(?<content_type>([^ ]*))$/',
  tag        => 'forward.squid.access',

  config     => {
    'path' => '/var/log/squid3/access.log',
  },
}

fluentd::source { 'squid_cache':
  configfile => 'squid',
  type       => 'tail',
  format     => 'none',
  tag        => 'forward.squid.cache',
  config     => {
    'path' => '/var/log/squid3/cache.log',
  },
}

fluentd::source { 'squid_store':
  configfile => 'squid',
  type       => 'tail',
  format     => 'none',
  tag        => 'forward.squid.store',
  config     => {
    'path' => '/var/log/squid3/store.log',
  },
}

fluentd::configfile { 'iptables': }

fluentd::source { 'iptables':
    configfile => 'iptables',
    type       => 'tail',
    format     => 'none',
    tag        => 'forward.iptables',
    config     => {
        'path' => '/var/log/iptables.log',
    },
}
