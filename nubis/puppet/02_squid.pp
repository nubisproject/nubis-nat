# Configure squid here, mostly using the puppet-squid module

class { '::squid3':
    use_deprecated_opts           => $use_deprecated_opts,
    ssl_ports                     => [
        '443         # https',
        '873         # rsync',
        '8000        # http alternate',
        '9418        # git',
    ],
    safe_ports                    => [
        '21          # ftp',
        '80          # http',
        '443         # https',
        '563         # nntp',
        '70          # gopher',
        '210         # wais',
        '1025-65535  # unregistered ports',
        '873         # rsync',
        '8000        # http alternate',
        '9418        # git',
    ],
    acl                           => [
        "allow_regex_domains dstdom_regex parameters(\"/etc/${service_name}/allow_regex_domains.txt\")",
        "allow_domains dstdomain parameters(\"/etc/${service_name}/allow_domains.txt\")",
        "allow_subnets dst \"/etc/${service_name}/allow_subnets.txt\"",
        "deny_subnets dst \"/etc/${service_name}/deny_subnets.txt\"",
        "deny_domains dstdomain parameters(\"/etc/${service_name}/deny_domains.txt\")",
    ],
    http_access                   => [
        'allow allow_regex_domains',
        'allow allow_domains',
        'allow allow_subnets',
        'deny deny_subnets',
        'deny deny_domains',
    ],
    cache                         => [ 'deny all' ],
    server_persistent_connections => 'off',
    template                      => 'short',
}

file {
    "/etc/${::squid3::params::service_name}/allow_regex_domains.txt":
        ensure  => present,
        source  => 'puppet:///nubis/files/proxy/allow_regex_domains.txt',
        require => Class['squid3'];

    "/etc/${::squid3::params::service_name}/allow_domains.txt":
        ensure  => present,
        source  => 'puppet:///nubis/files/proxy/allow_domains.txt',
        require => Class['squid3'];

    "/etc/${::squid3::params::service_name}/allow_subnets.txt":
        ensure  => present,
        source  => 'puppet:///nubis/files/proxy/allow_subnets.txt',
        require => Class['squid3'];

    "/etc/${::squid3::params::service_name}/deny_domains.txt":
        ensure  => present,
        source  => 'puppet:///nubis/files/proxy/deny_domains.txt',
        require => Class['squid3'];

    "/etc/${::squid3::params::service_name}/deny_subnets.txt":
        ensure  => present,
        source  => 'puppet:///nubis/files/proxy/deny_subnets.txt',
        require => Class['squid3'];

    '/etc/confd':
        ensure  => directory,
        recurse => true,
        purge   => false,
        owner   => 'root',
        group   => 'root',
        source  => "puppet:///nubis/files/proxy/confd-${::squid3::params::service_name}",
        require => Class['squid3'];

    '/etc/consul/svc-squid.json':
        owner  => 'root',
        group  => 'root',
        mode   => '0644',
        source => "puppet:///nubis/files/proxy/consul-svc-${::squid3::params::service_name}.json";

}

if $::osfamily == 'RedHat' {
  exec { 'config_file_permissions':
    command => "/bin/chmod 744 ${::squid3::params::config_file}",
  }
}
