case $::osfamily {
    'RedHat': {
        $service_name                   = 'squid'
        $use_deprecated_opts            = true
        $makepasswd_package_version     = '5.44.1.15-5.12.amzn1'
        $makepasswd_package_name        = 'expect'
        $git_package_version            = '2.7.3-1.46.amzn1'
        $git_package_name               = 'git'
        $package_manager_update_command = '/usr/bin/yum check-update'
        $motd_update_command            = '/usr/sbin/update-motd'
    }
    'Debian', 'Ubuntu': {
        $service_name                   = 'squid3'
        $use_deprecated_opts            = false
        $makepasswd_package_version     = '1.10-9'
        $makepasswd_package_name        = 'makepasswd'
        $git_package_version            = '1:1.9.1-1ubuntu0.1'
        $git_package_name               = 'git'
        $package_manager_update_command = '/usr/bin/apt-get update'
        $motd_update_command            = '/bin/run-parts /etc/update-motd.d/ > /var/run/motd.dynamic'
    }
}



