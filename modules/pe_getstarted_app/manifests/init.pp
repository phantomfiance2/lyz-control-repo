# @summary A short summary of the purpose of this class
#
# A description of what this class does
#
# @example
#   include pe_getstarted_app
class pe_getstarted_app (
  $content = "<?php phpinfo() ?>\n",
) {

  class { 'apache':
    mpm_module => 'prefork',
  }

  include apache::mod::php

  apache::vhost { 'pe_getstarted_app':
    port     => '80',
    docroot  => '/var/www/pe_getstarted_app',
    priority => '10',
  }

  file { '/var/www/pe_getstarted_app/index.php':
    ensure  => file,
    content => $content,
    mode    => '0644',
  }

}
