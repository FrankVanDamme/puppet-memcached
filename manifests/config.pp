# == Class: memcached::config
define memcached::config (
  $log_file,
  $memory_max,
  $listen_port,
  $listen_ip,
  $memcache_user,
  $connection_limit,
  $socket,
  $mask,
){


  file { "/etc/memcached.${name}.conf":
    ensure  => present,
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    content => template('memcached/memcached.conf.erb'),
  }

}
