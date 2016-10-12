case $::osfamily {
    'RedHat': {
        $service_name                   = 'squid'
        $use_deprecated_opts            = true
        $motd_update_command            = '/usr/sbin/update-motd'
    }
    'Debian', 'Ubuntu': {
        $service_name                   = 'squid3'
        $use_deprecated_opts            = false
        $motd_update_command            = '/bin/run-parts /etc/update-motd.d/ > /var/run/motd.dynamic'
    }
}



