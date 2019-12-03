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
        tag     => $tag,
    }


  case $enable_memcached {
    'no'   : { $enable = false }
    default: { $enable = true }
  }

  service { "memcached_$name":
    ensure => running,
    enable => $enable,
  }

}
