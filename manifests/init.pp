# patchman class

class patchman {

  class { 'patchman::repo':
    stage => setup,
  }
}
