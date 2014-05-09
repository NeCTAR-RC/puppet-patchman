class patchman($server, $port) {

  $dependencies = ['update-notifier-common', 'curl']

  package { $dependencies:
    ensure => installed,
  }

  file { '/etc/patchman':
    ensure => directory,
    owner  => root,
    group  => root,
    mode   => '0750',
  }

  file { '/etc/patchman/conf.d':
    ensure => directory,
    owner  => root,
    group  => root,
    mode   => '0750',
  }

  file { '/usr/local/sbin/patchman-client':
    source => 'puppet:///modules/patchman/patchman-client',
    owner  => root,
    group  => adm,
    mode   => '0740',
  }

  cron { 'patchman':
    ensure  => present,
    command => "/bin/sleep $((RANDOM\\%600)); PATH=/bin:/sbin:/usr/bin:/usr/sbin /usr/local/sbin/patchman-client",
    user    => 'root',
    minute  => '00',
    hour    => '07',
  }

  file { '/etc/patchman/patchman-client.conf':
    content => template('patchman/patchman-client.conf.erb'),
    owner   => root,
    group   => root,
    mode    => '0600',
    require => File['/etc/patchman'],
  }

  file { '/etc/apt/apt.conf.d/05patchman':
    source => 'puppet:///modules/patchman/apt-hook',
    owner  => root,
    group  => root,
    mode   => '0644',
  }
}
