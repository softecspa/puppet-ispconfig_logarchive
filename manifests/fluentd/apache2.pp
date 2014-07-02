class ispconfig_logarchive::fluentd::apache2 {

  $input_opts = merge($ispconfig_logarchive::params::apache2_fluentd_input_defaults, $ispconfig_logarchive::fluentd_apache2_input_opts)

  fluentd::configfile { 'apache2': }
  fluentd::source { 'apache_main':
    configfile  => 'apache2',
    type        => 'tail',
    format      => 'apache2',
    tag         => "${ispconfig_logarchive::destination}.apache.access_log",
    config      => $input_opts,
    notify      => Class['fluentd::service']
  }

  create_resources("ispconfig_logarchive::fluentd::${ispconfig_logarchive::destination}::apache2",{'apache2' => {'custom_config' => $ispconfig_logarchive::fluentd_apache2_output_opts}})

}
