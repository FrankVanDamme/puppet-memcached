# == Class: memcached::service
define memcached::service ( 
    $enable_memcached = 'yes'
) {
    $label=$name
    $jobname="memcached_$label"

    file { "/etc/systemd/system/${jobname}.service":
        content => template("$module_name/memcached.systemd.erb"),
        notify  => Exec['memcached_refresh_systemd'],
        purge   => true,
    }

    case $enable_memcached {
        'no': { 
            $enable = false 
            $ensure = stopped
        }
        'yes': { 
            $enable = true 
            $ensure = running
        }
        default: {
            fail("enable_memcached should be 'yes' or 'no' (with quotes)!")
        }
    }

    service { "memcached_$name":
        ensure => $ensure,
        enable => $enable,
    }

}
