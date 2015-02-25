# client class for patchman, installs cronjob and package

class patchman::client($server, $port) {

  $dependencies = ['update-notifier-common', 'curl']

  package { $dependencies:
    ensure => installed,
  }

  package { 'patchman-client':
    ensure => installed,
  }

  file { '/etc/patchman/conf.d':
    ensure  => directory,
    owner   => root,
    group   => root,
    mode    => '0750',
    require => Package['patchman-client'],
  }

  cron { 'patchman':
    ensure  => present,
    command => "/bin/sleep $((RANDOM\\%600)); PATH=/bin:/sbin:/usr/bin:/usr/sbin /usr/bin/patchman-client",
    user    => 'root',
    minute  => '00',
    hour    => '07',
  }

  file { '/etc/patchman/patchman-client.conf':
    content => template('patchman/patchman-client.conf.erb'),
    owner   => root,
    group   => root,
    mode    => '0600',
    require => Package['patchman-client'],
  }
}
