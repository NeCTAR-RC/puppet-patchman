# remove all traces of patchman

class patchman::purgeclient {

  package { 'patchman-client':
    ensure => purged,
  }

  file { '/etc/patchman/conf.d':
    ensure => absent,
    force  => true,
    before => Package['patchman-client'],
  }

  cron { 'patchman':
    ensure  => absent,
    require => Package['patchman-client']
  }

  file { '/etc/patchman/patchman-client.conf':
    ensure => absent,
    before => Package['patchman-client'],
  }
}
