# == Class nzbget::service
#
# This class is meant to be called from nzbget.
# It ensure the service is running.
#

class nzbget::service {
    file { '/etc/systemd/system/nzbget.service':
      ensure  => file,
      owner   => 'root',
      group   => 'root',
      mode    => '0644',
      require => Package[$nzbget::packages],
      content => template('nzbget/nzbget.systemd.erb'),
    }

    service { 'nzbget':
      ensure     => $nzbget::service_ensure,
      enable     => $nzbget::service_enable,
      hasrestart => true,
      hasstatus  => true,
      provider   => 'systemd',
      subscribe  => Concat[$nzbget::config_file],
    }

    File['/etc/systemd/system/nzbget.service'] ~> Service['nzbget']
}
