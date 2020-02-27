class kylin::service {

  if $kylin::service_install {
    if $::service_provider == 'systemd' {

      exec { "systemctl-daemon-reload-${kylin::service_name}":
        command     => 'systemctl daemon-reload',
        refreshonly => true,
        path        => '/usr/bin',
      }

      file { "${kylin::service_name}.service":
        ensure  => file,
        path    => "/etc/systemd/system/${kylin::service_name}.service",
        mode    => '0644',
        content => template("kylin/service/${kylin::service_template}"),
      }

      file { "/etc/init.d/${kylin::service_name}":
        ensure => absent,
      }

      File["${kylin::service_name}.service"] ~> Exec["systemctl-daemon-reload-${kylin::service_name}"] -> Service[$kylin::service_name]

    } else {

      fail("The ${::service_provider} service provider is not supported.")

    }

    service { $kylin::service_name:
      ensure     => $kylin::service_ensure,
      enable     => $kylin::service_enable,
      hasstatus  => true,
      hasrestart => true,
    }
  } else {
    debug('Skipping service install')
  }
}

