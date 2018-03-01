class kylin::config {

  file { "${kylin::config_dir}/kylin.properties":
    ensure  => file,
    owner   => $kylin::kylin_user,
    group   => $kylin::kylin_group,
    content => template('kylin/config/kylin.properties.erb'),
    require => File[ $kylin::config_dir ],
  }

  file { "${kylin::config_dir}/kylin_hive_conf.xml":
    ensure  => file,
    owner   => $kylin::kylin_user,
    group   => $kylin::kylin_group,
    content => template('kylin/config/kylin_hive_conf.xml.erb'),
    require => File[ $kylin::config_dir ],
  }

  file { "${kylin::config_dir}/kylin_job_conf.xml":
    ensure  => file,
    owner   => $kylin::kylin_user,
    group   => $kylin::kylin_group,
    content => template('kylin/config/kylin_job_conf.xml.erb'),
    require => File[ $kylin::config_dir ],
  }

  file { "${kylin::config_dir}/kylin_job_conf_inmem.xml":
    ensure  => file,
    owner   => $kylin::kylin_user,
    group   => $kylin::kylin_group,
    content => template('kylin/config/kylin_job_conf_inmem.xml.erb'),
    require => File[ $kylin::config_dir ],
  }

  file { "${kylin::config_dir}/kylin-server-log4j.properties":
    ensure  => file,
    owner   => $kylin::kylin_user,
    group   => $kylin::kylin_group,
    content => template('kylin/config/kylin-server-log4j.properties.erb'),
    require => File[ $kylin::config_dir ],
  }

  if (versioncmp($kylin::version, '2.0.0') >= 0) {

    file { "${kylin::config_dir}/kylin-kafka-consumer.xml":
      ensure  => file,
      owner   => $kylin::kylin_user,
      group   => $kylin::kylin_group,
      content => template('kylin/config/kylin-kafka-consumer.xml.erb'),
      require => File[ $kylin::config_dir ],
    }

    file { "${kylin::config_dir}/kylin-tools-log4j.properties":
      ensure  => file,
      owner   => $kylin::kylin_user,
      group   => $kylin::kylin_group,
      content => template('kylin/config/kylin-tools-log4j.properties.erb'),
      require => File[ $kylin::config_dir ],
    }

  }

}
