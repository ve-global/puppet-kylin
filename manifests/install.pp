class kylin::install {

  file { $kylin::download_dir:
    ensure  => directory,
    owner   => $kylin::kylin_user,
    group   => $kylin::kyline_group,
  }

  file { $kylin::extract_dir:
    ensure  => directory,
    owner   => $kylin::kylin_user,
    group   => $kylin::kylin_group,
  }

  file { $kylin::log_dir:
    ensure  => directory,
    owner   => $kylin::kylin_user,
    group   => $kylin::kylin_group,
  }

  if $kylin::package_name == undef {
    include '::archive'

    archive { "${kylin::download_dir}/${kylin::basefilename}":
      ensure          => present,
      extract         => true,
      extract_command => 'tar xfz %s --strip-components=1',
      extract_path    => $kylin::extract_dir,
      source          => $kylin::package_url,
      creates         => "${kylin::extract_dir}/bin",
      cleanup         => true,
      username        => $kylin::mirror_username,
      password        => $kylin::mirror_password,
      user            => $kylin::kylin_user,
      group           => $kylin::kylin_group,
      require         => [
        File[$kylin::download_dir],
        File[$kylin::extract_dir],
      ],
      before          => File[$kylin::install_dir],
    }
    if (versioncmp($kylin::version, '3.0.0') >= 0){
      archive { "${kylin::extract_dir}/tomcat/lib/commons-configuration-1.6.jar":
        ensure   => present,
        source   => 'https://repo1.maven.org/maven2/commons-configuration/commons-configuration/1.6/commons-configuration-1.6.jar',
        creates  => "${kylin::extract_dir}/tomcat/lib/commons-configuration-1.6.jar",
        cleanup  => false,
        username => $kylin::kylin_user,
        group    => $kylin::kylin_group,
        require  => Archive["${kylin::download_dir}/${kylin::basefilename}"],
        before   => File[$kylin::install_dir],
      }
    }
  } else {
    package { $kylin::package_name:
      ensure => $kylin::package_ensure,
      before => File[$kylin::install_dir],
    }
  }

  file { $kylin::install_dir:
    ensure  => link,
    target  => $kylin::extract_dir,
    owner   => $kylin::kylin_user,
    group   => $kylin::kylin_group,
    require => File[ $kylin::extract_dir ],
  }

  file { "${kylin::install_dir}/logs":
    ensure  => link,
    target  => $kylin::log_dir,
    owner   => $kylin::kylin_user,
    group   => $kylin::kylin_group,
    require => File[ $kylin::install_dir, $kylin::log_dir ],
  }

  file { $kylin::config_dir:
    ensure  => directory,
    owner   => $kylin::kylin_user,
    group   => $kylin::kylin_group,
    require => File[ $kylin::install_dir ],
  }

}
