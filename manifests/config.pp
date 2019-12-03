# == Class: memcached::config
define memcached::config (
  $enable_memcached,
  $log_file,
  $memory_max,
  $listen_port,
  $listen_ip,
  $memcache_user,
  $connection_limit,
  $socket,
){


  file { "/etc/memcached.$name.conf":
    ensure  => present,
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    content => template('memcached/memcached.conf.erb'),
  }

}
