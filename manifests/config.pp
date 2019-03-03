# == Class nzbget::config
#
# This class is called from nzbget for service config.
#

class nzbget::config {
  if ($::nzbget::manage_service_dirs[0]) {
    file { ${nzbget::managed_service_dirs}:
      ensure => directory,
      owner  => $::nzbget::user,
      group  => $::nzbget::group,
      mode   => '0750',
    }
  }

  if ($::nzbget::manage_data_dirs[0]) {
    file { $nzbget::managed_data_dirs:
      ensure => directory,
      owner  => $::nzbget::user,
      group  => $::nzbget::group,
      mode   => '0750',
    }
  }

  if ($::nzbget::manage_certs) {
    if ($::nzbget::secure_cert) {
      file { $::nzbget::secure_cert:
        ensure => present,
        owner  => $::nzbget::user,
        group  => $::nzbget::group,
        mode   => '0400',
        source => "puppet:///modules/nzbget/${nzbget::secure_cert_file}",
      }
    }

    if ($::nzbget::secure_key) {
      file { $::nzbget::secure_key:
        ensure => present,
        owner  => $::nzbget::user,
        group  => $::nzbget::group,
        mode   => '0400',
        source => "puppet:///modules/nzbget/${nzbget::secure_key_file}",
      }
    }
  }

  if ($::nzbget::manage_pass_file) {
    if ($nzbget::unpack_pass_file) {
      file { $nzbget::unpack_pass_file:
        ensure => present,
        owner  => $::nzbget::user,
        group  => $::nzbget::group,
        mode   => '0400',
        source => "puppet:///modules/nzbget/${nzbget::unpack_pass_file_name}",
      }
    }
  }

  file { $nzbget::log_file:
    ensure => present,
    owner  => $::nzbget::user,
    group  => $::nzbget::group,
    mode   => '0700',
  }

  file { $nzbget::lock_file:
    ensure => present,
    owner  => $::nzbget::user,
    group  => $::nzbget::group,
    mode   => '0700',
  }

  concat { $nzbget::config_file:
    ensure => 'present',
    owner  => $::nzbget::user,
    group  => $::nzbget::group,
    mode   => '0640',
  }

  concat::fragment { 'head':
    target  => $nzbget::config_file,
    content => template('nzbget/nzbget.conf_head.erb'),
    order   => '01',
  }

  concat::fragment { 'paths':
    target  => $nzbget::config_file,
    content => template('nzbget/nzbget.conf_paths.erb'),
    order   => '03',
  }

  concat::fragment { 'servers':
    target  => $nzbget::config_file,
    content => template('nzbget/nzbget.conf_servers.erb'),
    order   => '05',
  }

  concat::fragment { 'security':
    target  => $nzbget::config_file,
    content => template('nzbget/nzbget.conf_security.erb'),
    order   => '07',
  }

  concat::fragment { 'categories':
    target  => $nzbget::config_file,
    content => template('nzbget/nzbget.conf_categories.erb'),
    order   => '09',
  }

  concat::fragment { 'rss_feeds':
    target  => $nzbget::config_file,
    content => template('nzbget/nzbget.conf_rss_feeds.erb'),
    order   => '11',
  }

  concat::fragment { 'incoming':
    target  => $nzbget::config_file,
    content => template('nzbget/nzbget.conf_incoming.erb'),
    order   => '13',
  }

  concat::fragment { 'download':
    target  => $nzbget::config_file,
    content => template('nzbget/nzbget.conf_download.erb'),
    order   => '15',
  }

  concat::fragment { 'connection':
    target  => $nzbget::config_file,
    content => template('nzbget/nzbget.conf_connection.erb'),
    order   => '17',
  }

  concat::fragment { 'logging':
    target  => $nzbget::config_file,
    content => template('nzbget/nzbget.conf_logging.erb'),
    order   => '19',
  }

  concat::fragment { 'display':
    target  => $nzbget::config_file,
    content => template('nzbget/nzbget.conf_display.erb'),
    order   => '21',
  }

  concat::fragment { 'scheduler':
    target  => $nzbget::config_file,
    content => template('nzbget/nzbget.conf_scheduler.erb'),
    order   => '23',
  }

  concat::fragment { 'check_and_repair':
    target  => $nzbget::config_file,
    content => template('nzbget/nzbget.conf_check_and_repair.erb'),
    order   => '25',
  }

  concat::fragment { 'unpack':
    target  => $nzbget::config_file,
    content => template('nzbget/nzbget.conf_unpack.erb'),
    order   => '27',
  }

  concat::fragment { 'extension':
    target  => $nzbget::config_file,
    content => template('nzbget/nzbget.conf_extension.erb'),
    order   => '29',
  }
}
