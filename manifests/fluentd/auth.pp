class ispconfig_logarchive::fluentd::auth {

  $input_opts     = merge($ispconfig_logarchive::params::auth_fluentd_input_defaults, $ispconfig_logarchive::fluentd_auth_input_opts)

  fluentd::configfile { 'auth': }
  fluentd::source { 'auth_main':
    configfile  => 'auth',
    type        => 'tail',
    format      => 'syslog',
    tag         => "${ispconfig_logarchive::destination}.auth.log",
    config      => $input_opts,
    notify      => Class['fluentd::service']
  }

  create_resources("ispconfig_logarchive::fluentd::${ispconfig_logarchive::destination}::auth",{'auth' => {'custom_config' => $ispconfig_logarchive::fluentd_auth_output_opts}})
}
