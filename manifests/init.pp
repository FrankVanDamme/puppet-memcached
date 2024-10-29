# == Class: memcached
#
# Main class to install and configure Memcached.
#
# === Examples
#
# Install Memcached.
#
#  class { 'memcached': }
#
# Install Memcached with specific config.
#
#  class { 'memcached': }
#    memory_max  => 32,
#    listen_port => 11212,
#  }
#
# === Authors
#
# Joshua B. Bussdieker <jbussdieker@gmail.com>
#
# === Copyright
#
# Copyright 2015 Joshua B. Bussdieker, unless otherwise noted.
#
class memcached(
  $enable_default_memcached = 'yes',
  $log_file           = '/var/log/memcached.log',
  $memory_max         = 64,
  $listen_port        = 11211,
  $listen_ip          = '127.0.0.1',
  $memcache_user      = 'memcache',
  $connection_limit   = 1024,
  $socket             = undef,
  Boolean $privatetmp = true,
  $mask               = '700',
) {
    class { 'memcached::package':
    }

    file { '/etc/memcached':
        ensure => directory,
        owner  => 'root',
        group  => 'root',
        mode   => '0655',
    }

    file { '/etc/default/memcached':
        ensure  => present,
        owner   => 'root',
        group   => 'root',
        mode    => '0644',
        content => template('memcached/default.erb'),
    }

    exec { "memcached_refresh_systemd":
        command     => "/bin/systemctl daemon-reload",
        refreshonly => true,
    }

    case $enable_default_memcached {
        'no': {
            $enable = false
            $ensure = stopped
        }
        'yes': {
            $enable = true
            $ensure = running
        }
        default: {
            fail("enable_default_memcached should be 'yes' or 'no' (with quotes)!")
        }
    }

    service { "memcached":
        ensure => $ensure,
        enable => $enable,
    }

    Memcached::Instance <| |>
}
