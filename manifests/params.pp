class kylin::params {

  #installation related definitions
  $version                    = '1.6.4'
  $dist_version               = 'hbase1.x'
  $install_dir                = '/opt/kylin'
  $mirror_url                 = 'http://apache.rediris.es'
  $mirror_username            = undef
  $mirror_password            = undef
  $download_dir               = '/var/tmp/kylin'
  $log_dir                    = '/var/log/kylin'
  $pid_dir                    = '/var/run/kylin'

  $config_dir                 = '/opt/kylin/conf'

  $package_name               = undef
  $package_ensure             = present

  $install_java               = false
  $java_version               = '8'
  $java_home                  = '/usr/jdk64/jdk1.8.0_77'
  $spark_home                 = '/usr/hdp/2.5.3.0-37/spark'
  $hive_home                  = '/usr/hdp/2.5.3.0-37/hive'
  $hcat_home                  = '/usr/hdp/2.5.3.0-37/hive-hcatalog'

  $kylin_group                = 'kylin'
  $kylin_gid                  = undef
  $kylin_user                 = 'kylin'
  $kylin_uid                  = undef

  $service_install            = true
  $service_name               = 'kylin'
  $service_ensure             = 'running'
  $service_enable             = true

  $kylin_jvm_settings         = '-Xms1024M -Xmx4096M -Xss1024K -XX:MaxPermSize=128M -verbose:gc -XX:+PrintGCDetails -XX:+PrintGCDateStamps -Xloggc:$KYLIN_HOME/logs/kylin.gc.$$ -XX:+UseGCLogFileRotation -XX:NumberOfGCLogFiles=10 -XX:GCLogFileSize=64M'

  $default_kylin_3_properties = {}

  $default_kylin_3_hive_conf    = {
    'dfs.replication'                               => 2,
    'hive.exec.compress.output'                     => true,
    'hive.auto.convert.join'                        => true,
    'hive.auto.convert.join.noconditionaltask'      => true,
    'hive.auto.convert.join.noconditionaltask.size' => 100000000,
    'mapreduce.job.split.metainfo.maxsize'          => -1,
    'hive.stats.autogather'                         => true,
    'hive.merge.mapfiles'                           => false,
    'hive.merge.mapredfiles'                        => false,
  }

  $default_kylin_3_job_conf     = {
    'mapreduce.job.split.metainfo.maxsize'            => -1,
    'mapreduce.map.output.compress'                   => true,
    'mapreduce.output.fileoutputformat.compress'      => true,
    'mapreduce.output.fileoutputformat.compress.type' => 'BLOCK',
    'mapreduce.job.max.split.locations'               => 2000,
    'dfs.replication'                                 => 2,
    'mapreduce.task.timeout'                          => 3600000,
  }

  $default_kylin_3_job_conf_inmem = {
    'mapreduce.job.is-mem-hungry'                     => 'true',
    'mapreduce.job.split.metainfo.maxsize'            => -1,
    'mapreduce.map.output.compress'                   => true,
    'mapreduce.output.fileoutputformat.compress'      => true,
    'mapreduce.output.fileoutputformat.compress.type' => 'BLOCK',
    'mapreduce.job.max.split.locations'               => 2000,
    'dfs.replication'                                 => 2,
    'mapreduce.task.timeout'                          => 7200000,
    'mapreduce.map.memory.mb'                         => 3072,
    'mapreduce.map.java.opts'                         => '-Xmx2700m -XX:OnOutOfMemoryError=\'kill -9 %p\'',
    'mapreduce.task.io.sort.mb'                       => 200,
  }

  $default_kylin_3_kafka_consumer          = {
    'session.timeout.ms' => 30000,
  }
  $default_kylin_3_server_log4j_properties = {
    'log4j.appender.file'                                                          => 'org.apache.log4j.RollingFileAppender',
    'log4j.appender.file.layout'                                                   => 'org.apache.log4j.PatternLayout',
    'log4j.appender.file.File'                                                     => '${catalina.home}/../logs/kylin.log',
    'log4j.appender.file.layout.ConversionPattern'                                 => '%d{ISO8601} %-5p [%t] %c{2}:%L : %m%n',
    'log4j.appender.file.Append'                                                   => 'true',
    'log4j.appender.file.MaxFileSize'                                              => '268435456',
    'log4j.appender.file.MaxBackupIndex'                                           => '10',
    'log4j.appender.realtime'                                                      => 'org.apache.log4j.RollingFileAppender',
    'log4j.appender.realtime.layout'                                               => 'org.apache.log4j.PatternLayout',
    'log4j.appender.realtime.File'                                                 => '${catalina.home}/../logs/streaming_coordinator.log',
    'log4j.appender.realtime.layout.ConversionPattern'                             => '%d{ISO8601} %-5p [%t] %c{2}:%L : %m%n',
    'log4j.appender.realtime.Append'                                               => 'true',
    'log4j.appender.realtime.MaxFileSize'                                          => '268435456',
    'log4j.appender.realtime.MaxBackupIndex'                                       => '10',
    'log4j.rootLogger'                                                             => 'INFO',
    'log4j.logger.org.apache.kylin'                                                => 'DEBUG,file',
    'log4j.logger.org.springframework'                                             => 'WARN,file',
    'log4j.logger.org.springframework.security'                                    => 'INFO,file',
    'log4j.additivity.logger.org.apache.kylin.stream'                              => 'false',
    'log4j.logger.org.apache.kylin.stream'                                         => 'TRACE,realtime',
    'log4j.logger.org.apache.kylin.job'                                            => 'DEBUG,realtime',
    'log4j.logger.org.apache.kylin.rest.service.StreamingCoordinatorService'       => 'DEBUG,realtime',
    'log4j.logger.org.apache.kylin.rest.service.StreamingV2Service'                => 'DEBUG,realtime',
    'log4j.logger.org.apache.kylin.rest.controller.StreamingCoordinatorController' => 'DEBUG,realtime',
    'log4j.logger.org.apache.kylin.rest.controller.StreamingV2Controller'          => 'DEBUG,realtime',
  }
  $default_kylin_3_tools_log4j_properties  = {
    'log4j.rootLogger'                               => 'INFO,stderr',
    'log4j.appender.stderr'                          => 'org.apache.log4j.ConsoleAppender',
    'log4j.appender.stderr.Target'                   => 'System.err',
    'log4j.appender.stderr.layout'                   => 'org.apache.log4j.PatternLayout',
    'log4j.appender.stderr.layout.ConversionPattern' => '%d{ISO8601} %-5p [%t] %c{2}:%L : %m%n',
    'log4j.logger.org.apache.kylin',                 => 'DEBUG',
    'log4j.logger.org.springframework',              => 'WARN',
    'log4j.logger.org.apache.kylin.tool.shaded'      => 'INFO',
  }

  $default_kylin_2_properties = {
    ### METADATA | ENV ###
    'kylin.metadata.url'                                    => 'kylin_metadata@hbase',
    'kylin.env.hdfs-working-dir'                            => '/kylin',
    'kylin.env'                                             => 'QA',
    ### SERVER | WEB ###
    'kylin.server.mode'                                     => 'all',
    'kylin.server.cluster-servers'                          => 'localhost:7070',
    'kylin.web.timezone'                                    => 'GMT+8',
    'kylin.web.cross-domain-enabled'                        => true,
    ### SOURCE ###
    'kylin.source.hive.client'                              => 'cli',
    'kylin.source.hive.keep-flat-table'                     => false,
    'kylin.source.hive.database-for-flat-table'             => 'default',
    'kylin.source.hive.redistribute-flat-table'             => true,
    ### STORAGE ###
    'kylin.storage.url'                                     => 'hbase',
    'kylin.storage.hbase.compression-codec'                 => 'none',
    'kylin.storage.hbase.region-cut-gb'                     => 5,
    'kylin.storage.hbase.hfile-size-gb'                     => 2,
    'kylin.storage.hbase.min-region-count'                  => 1,
    'kylin.storage.hbase.max-region-count'                  => 500,
    'kylin.storage.hbase.owner-tag'                         => 'whoami@kylin.apache.org',
    'kylin.storage.hbase.coprocessor-mem-gb'                => 3,
    'kylin.storage.partition.aggr-spill-enabled'            => true,
    'kylin.storage.partition.max-scan-bytes'                => 3221225472,
    ### JOB ###
    'kylin.job.retry'                                       => 0,
    'kylin.job.max-concurrent-jobs'                         => 10,
    'kylin.job.sampling-percentage'                         => 100,
    'kylin.job.status.with.kerberos'                        => false,
    'kylin.job.step.timeout'                                => 7200,
    ### ENGINE ###
    'kylin.engine.mr.yarn-check-interval-seconds'           => 10,
    'kylin.engine.mr.reduce-input-mb'                       => 500,
    'kylin.engine.mr.max-reducer-number'                    => 500,
    'kylin.engine.mr.mapper-input-rows'                     => 1000000,
    'kylin.engine.mr.build-dict-in-reducer'                 => true,
    'kylin.engine.mr.uhc-reducer-count'                     => 1,
    ### CUBE | DICTIONARY ###
    'kylin.cube.algorithm'                                  => 'layer',
    'kylin.cube.algorithm.layer-or-inmem-threshold'         => 7,
    'kylin.cube.aggrgroup.max-combination'                  => 4096,
    'kylin.snapshot.max-mb'                                 => 300,
    ### QUERY ###
    'kylin.query.max-scan-bytes'                            => 0,
    'kylin.query.udf.version'                               => 'org.apache.kylin.query.udf.VersionUDF',
    'kylin.query.udf.concat'                                => 'org.apache.kylin.query.udf.ConcatUDF',
    'kylin.query.cache-enabled'                             => true,
    ### SECURITY ###
    'kylin.security.profile'                                => 'testing',
    'kylin.security.acl.default-role'                       => 'ROLE_ANALYST,ROLE_MODELER',
    'kylin.security.acl.admin-role'                         => 'ROLE_ADMIN',
    'kylin.security.ldap.connection-server'                 => 'ldap://ldap_server:389',
    'kylin.security.ldap.connection-username'               => '',
    'kylin.security.ldap.connection-password'               => '',
    'kylin.security.ldap.user-search-base'                  => '',
    'kylin.security.ldap.user-search-pattern'               => '',
    'kylin.security.ldap.user-group-search-base'            => '',
    'kylin.security.ldap.service-search-base'               => '',
    'kylin.security.ldap.service-search-pattern'            => '',
    'kylin.security.ldap.service-group-search-base'         => '',
    'kylin.security.saml.metadata-file'                     => 'classpath:sso_metadata.xml',
    'kylin.security.saml.metadata-entity-base-url'          => 'https://hostname/kylin',
    'kylin.security.saml.context-scheme'                    => 'https',
    'kylin.security.saml.context-server-name'               => 'hostname',
    'kylin.security.saml.context-server-port'               => 443,
    'kylin.security.saml.context-path'                      => '/kylin',
    ### Spark Engine Configs ###
    'kylin.engine.spark.rdd-partition-cut-mb'               => 10,
    'kylin.engine.spark.min-partition'                      => 1,
    'kylin.engine.spark.max-partition'                      => 5000,
    'kylin.engine.spark-conf.spark.master'                  => 'yarn',
    'kylin.engine.spark-conf.spark.submit.deployMode'       => 'cluster',
    'kylin.engine.spark-conf.spark.yarn.queue'              => 'default',
    'kylin.engine.spark-conf.spark.executor.memory'         => '1G',
    'kylin.engine.spark-conf.spark.executor.cores'          => 2,
    'kylin.engine.spark-conf.spark.executor.instances'      => 1,
    'kylin.engine.spark-conf.spark.eventLog.enabled'        => true,
    'kylin.engine.spark-conf.spark.eventLog.dir'            => 'hdfs\:///kylin/spark-history',
    'kylin.engine.spark-conf.spark.history.fs.logDirectory' => 'hdfs\:///kylin/spark-history',
  }

  $default_kylin_1_properties = {
    ### SERVICE ###
    'kyin.server.mode'                               => 'all',
    'kylin.owner'                                    => 'whoami@kylin.apache.org',
    'kylin.rest.servers'                             => 'localhost:7070',
    'kylin.rest.timezone'                            => 'GMT+8',
    ### SOURCE ###
    'kylin.hive.client'                              => 'cli',
    'kylin.hive.keep.flat.table'                     => false,
    ### STORAGE ###
    'kylin.metadata.url'                             => 'kylin_metadata@hbase',
    'kylin.storage.url'                              => 'hbase',
    'kylin.hdfs.working.dir'                         => '/kylin',
    'kylin.hbase.region.cut'                         => 5,
    'kylin.hbase.hfile.size.gb'                      => 2,
    'kylin.hbase.region.count.min'                   => 1,
    'kylin.hbase.region.count.max'                   => 500,
    ### JOB ###
    'kylin.job.retry'                                => 0,
    'kylin.job.run.as.remote.cmd'                    => false,
    'kylin.job.remote.cli.hostname'                  => '',
    'kylin.job.remote.cli.port'                      => 22,
    'kylin.job.remote.cli.username'                  => '',
    'kylin.job.remote.cli.password'                  => '',
    'kylin.job.remote.cli.working.dir'               => '/tmp/kylin',
    'kylin.job.concurrent.max.limit'                 => 10,
    'kylin.job.yarn.app.rest.check.interval.seconds' => 10,
    'kylin.job.hive.database.for.intermediatetable'  => 'default',
    'kylin.job.cubing.inmem.sampling.percent'        => 100,
    'kylin.job.status.with.kerberos'                 => false,
    'kylin.job.mapreduce.default.reduce.input.mb'    => 500,
    'kylin.job.mapreduce.max.reducer.number'         => 500,
    'kylin.job.mapreduce.mapper.input.rows'          => 1000000,
    'kylin.job.step.timeout'                         => 7200,
    ### CUBE ###
    'kylin.cube.algorithm'                           => 'auto',
    'kylin.cube.algorithm.auto.threshold'            => 8,
    'kylin.cube.aggrgroup.max.combination'           => 4096,
    'kylin.dictionary.max.cardinality'               => 5000000,
    'kylin.table.snapshot.max_mb'                    => 300,
    ### QUERY ###
    'kylin.query.scan.threshold'                     => 10000000,
    'kylin.query.mem.budget'                         => 3221225472,
    'kylin.query.coprocessor.mem.gb'                 => 3,
    'kylin.query.security.enabled'                   => true,
    'kylin.query.cache.enabled'                      => true,
    ### SECURITY ###
    'kylin.security.profile'                         => 'testing',
    'acl.defaultRole'                                => 'ROLE_ANALYST,ROLE_MODELER',
    'acl.adminRole'                                  => 'ROLE_ADMIN',
    'ldap.server'                                    => 'ldap://ldap_server:389',
    'ldap.username'                                  => '',
    'ldap.password'                                  => '',
    'ldap.user.searchBase'                           => '',
    'ldap.user.searchPattern'                        => '',
    'ldap.user.groupSearchBase'                      => '',
    'ldap.service.searchBase'                        => '',
    'ldap.service.searchPattern'                     => '',
    'ldap.service.groupSearchBase'                   => '',
    'saml.metadata.file'                             => 'classpath:sso_metadata.xml',
    'saml.metadata.entityBaseURL'                    => 'https://hostname/kylin',
    'saml.context.scheme'                            => 'https',
    'saml.context.serverName'                        => 'hostname',
    'saml.context.serverPort'                        => 443,
    'saml.context.contextPath'                       => '/kylin',
    ### MAIL ###
    'mail.enabled'                                   => false,
    'mail.host'                                      => '',
    'mail.username'                                  => '',
    'mail.password'                                  => '',
    'mail.sender'                                    => '',
    ### WEB ###
    'kylin.web.help.length'                          => 4,
    'kylin.web.help.0'                               => 'start|Getting Started|',
    'kylin.web.help.1'                               => 'odbc|ODBC Driver|',
    'kylin.web.help.2'                               => 'tableau|Tableau Guide|',
    'kylin.web.help.3'                               => 'onboard|Cube Design Tutorial|',
    'kylin.web.streaming.guide'                      => 'http://kylin.apache.org/',
    'kylin.web.hadoop'                               => '',
    'kylin.web.diagnostic'                           => '',
    'kylin.web.contact_mail'                         => '',
    'crossdomain.enable'                             => true,
    ### OTHER ###
    'deploy.env'                                     => 'QA',
  }

  $default_kylin_hive_conf    = {
    'dfs.replication'                               => 2,
    'hive.exec.compress.output'                     => true,
    'hive.auto.convert.join'                        => true,
    'hive.auto.convert.join.noconditionaltask'      => true,
    'hive.auto.convert.join.noconditionaltask.size' => 100000000,
    'mapreduce.job.split.metainfo.maxsize'          => -1,
    'hive.stats.autogather'                         => true,
    'hive.merge.mapfiles'                           => false,
    'hive.merge.mapredfiles'                        => false,
  }

  $default_kylin_job_conf     = {
    'mapreduce.job.split.metainfo.maxsize'            => -1,
    'mapreduce.map.output.compress'                   => true,
    'mapreduce.output.fileoutputformat.compress'      => true,
    'mapreduce.output.fileoutputformat.compress.type' => 'BLOCK',
    'mapreduce.job.max.split.locations'               => 2000,
    'dfs.replication'                                 => 2,
    'mapreduce.task.timeout'                          => 3600000,
  }

  $default_kylin_job_conf_inmem = {
    'mapreduce.job.split.metainfo.maxsize'            => -1,
    'mapreduce.map.output.compress'                   => true,
    'mapreduce.output.fileoutputformat.compress'      => true,
    'mapreduce.output.fileoutputformat.compress.type' => 'BLOCK',
    'mapreduce.job.max.split.locations'               => 2000,
    'dfs.replication'                                 => 2,
    'mapreduce.task.timeout'                          => 7200000,
    'mapreduce.map.memory.mb'                         => 3072,
    'mapreduce.map.java.opts'                         => '-Xmx2700m -XX:OnOutOfMemoryError=\'kill -9 %p\'',
    'mapreduce.task.io.sort.mb'                       => 200,
  }

  $default_kafka_consumer     = {
    'session.timeout.ms' => 30000,
  }

  $default_kylin_server_log4j_properties = {
    'log4j.appender.file'                          => 'org.apache.log4j.DailyRollingFileAppender',
    'log4j.appender.file.layout'                   => 'org.apache.log4j.PatternLayout',
    'log4j.appender.file.File'                     => '${catalina.home}/../logs/kylin.log', # lint:ignore:single_quote_string_with_variables
    'log4j.appender.file.layout.ConversionPattern' => '%d{ISO8601} %-5p [%t] %c{2}:%L : %m%n',
    'log4j.appender.file.Append'                   => true,
    'log4j.rootLogger=INFO,file'                   => 'INFO,file',
    'log4j.logger.org.apache.kylin'                => 'DEBUG',
    'log4j.logger.org.springframework'             => 'WARN',
    'log4j.logger.org.springframework.security'    => 'INFO',
  }

  $default_kylin_tools_log4j_properties = {
    'log4j.rootLogger'                               => 'INFO,stderr',
    'log4j.appender.stderr'                          => 'org.apache.log4j.ConsoleAppender',
    'log4j.appender.stderr.Target'                   => 'System.err',
    'log4j.appender.stderr.layout'                   => 'org.apache.log4j.PatternLayout',
    'log4j.appender.stderr.layout.ConversionPattern' => '%d{ISO8601} %-5p [%t %c{1}:%L]: %m%n',
    'log4j.logger.org.apache.kylin'                  => 'ERROR',
    'log4j.logger.org.springframework'               => 'WARN',
  }

}
