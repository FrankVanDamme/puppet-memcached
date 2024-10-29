# Create custom instance of memcached
define memcached::instance (
  $enable_memcached   = 'yes',
  $log_file           = $memcached::log_file,
  $memory_max         = $memcached::memory_max,
  $listen_port        = $memcached::listen_port,
  $listen_ip          = $memcached::listen_ip,
  $memcache_user      = $memcached::memcache_user,
  $connection_limit   = $memcached::connection_limit,
  $socket             = $memcached::socket,
  Boolean $privatetmp = $memcached::privatetmp,
  $mask               = $memcached::mask,
){
    memcached::config { $name:
        log_file         => $log_file,
        memory_max       => $memory_max,
        listen_port      => $listen_port,
        listen_ip        => $listen_ip,
        memcache_user    => $memcache_user,
        connection_limit => $connection_limit,
        socket           => $socket,
        notify           => Memcached::Service[$name],
        require          => Class['memcached::package'],
        mask             => $mask,
    }

    memcached::service { $name:
        enable_memcached => $enable_memcached,
        require          => Memcached::Config[$name],
        subscribe        => Class['memcached::package'],
    }
}
