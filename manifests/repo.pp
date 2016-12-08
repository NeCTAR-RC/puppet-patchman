# patchman repo class, needs to be in a stage before client class

class patchman::repo {

  if $::http_proxy and str2bool($::rfc1918_gateway) {
    $key_options = "http-proxy=${::http_proxy}"
  } else {
    $key_options = false
  }

  apt::key { 'patchman':
    id      => '198AF25376E7ACD8E123B0CDD30FB02B0412F522',
    server  => 'pgp.mit.edu',
    options => $key_options,
  }

  apt::source { 'patchman':
    location    => 'http://repo.openbytes.ie/ubuntu',
    release     => 'trusty',
    repos       => 'main',
  }
}

