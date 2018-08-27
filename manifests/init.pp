class kylin (
  $version                              = $kylin::params::version,
  $hbase_version                        = $kylin::params::hbase_version,
  $mirror_url                           = $kylin::params::mirror_url,
  $mirror_username                      = $kylin::params::mirror_username,
  $mirror_password                      = $kylin::params::mirror_password,

  $install_dir                          = $kylin::params::install_dir,
  $download_dir                         = $kylin::params::download_dir,
  $extract_dir                          = "/opt/kylin-${version}",
  $log_dir                              = $kylin::params::log_dir,
  $pid_dir                              = $kylin::params::pid_dir,

  $config_dir                           = $kylin::params::config_dir,

  $install_java                         = $kylin::params::install_java,
  $java_version                         = $kylin::params::java_version,
  $java_home                            = $kylin::params::java_home,
  $spark_home                           = $kylin::params::spark_home,
  $hive_home                            = $kylin::params::hive_home,
  $hcat_home                            = $kylin::params::hcat_home,

  $kylin_group                          = $kylin::params::kylin_group,
  $kylin_gid                            = $kylin::params::kylin_gid,
  $kylin_user                           = $kylin::params::kylin_user,
  $kylin_uid                            = $kylin::params::kylin_uid,

  $service_install                      = $kylin::params::service_install,
  $service_name                         = $kylin::params::service_name,
  $service_ensure                       = $kylin::params::service_ensure,
  $service_enable                       = $kylin::params::service_enable,

  $custom_kylin_properties              = {},
  $custom_kylin_hive_conf               = {},
  $custom_kylin_job_conf                = {},
  $custom_kylin_job_conf_inmem          = {},
  $custom_kylin_kafka_consumer          = {},
  $custom_kylin_server_log4j_properties = {},
  $custom_kylin_tools_log4j_properties  = {},
  $kylin_jvm_settings                   = $kylin::params::kylin_jvm_settings,


) inherits kylin::params {
  if(versioncmp($version, '2.0.0') >= 0 ) {
    $basefilename             = "apache-kylin-${version}-bin-hbase${hbase_version}.tar.gz"
    $default_kylin_properties = $kylin::params::default_kylin_2_properties
  } else {
    $basefilename             = "apache-kylin-${version}-hbase${hbase_version}-bin.tar.gz"
    $default_kylin_properties = $kylin::params::default_kylin_1_properties
  }

  $package_url = "${mirror_url}/kylin/apache-kylin-${version}/${basefilename}"

  if $install_java {
    java::oracle { "jdk${java_version}":
      ensure  => present,
      version => $java_version,
      java_se => 'jdk',
      before  => Archive[ "${download_dir}/${basefilename}" ],
    }
  }

  group { $kylin_group:
    ensure => present,
    gid    => $kylin_uid,
  }

  user { $kylin_user:
    ensure  => present,
    uid     => $kylin_uid,
    require => Group[$kylin_group],
  }

  $kylin_properties              = deep_merge($default_kylin_properties, $custom_kylin_properties)
  $kylin_hive_conf               = deep_merge($kylin::params::default_kylin_hive_conf, $custom_kylin_properties)
  $kylin_job_conf                = deep_merge($kylin::params::default_kylin_job_conf, $custom_kylin_job_conf)
  $kylin_job_conf_inmem          = deep_merge($kylin::params::default_kylin_job_conf_inmem, $custom_kylin_job_conf_inmem)
  $kylin_kafka_consumer          = deep_merge($kylin::params::default_kylin_kafka_consumer, $custom_kylin_kafka_consumer)
  $kylin_server_log4j_properties = deep_merge($kylin::params::default_kylin_server_log4j_properties, $custom_kylin_server_log4j_properties)
  $kylin_tools_log4j_properties  = deep_merge($kylin::parmas::default_kylin_tools_log4j_properties, $custom_kylin_tools_log4j_properties)

  anchor { '::kylin::start': } ->
  class { '::kylin::install': } ->
  class { '::kylin::config': } ~>
  class { '::kylin::service': } ->
  anchor { '::kylin::end': }

}
