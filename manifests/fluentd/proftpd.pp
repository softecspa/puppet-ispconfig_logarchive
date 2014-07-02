class ispconfig_logarchive::fluentd::proftpd {

  $input_opts     = merge($ispconfig_logarchive::params::proftpd_fluentd_input_defaults, $ispconfig_logarchive::fluentd_proftpd_input_opts)
  $tls_input_opts = merge($ispconfig_logarchive::params::proftpd_tls_fluentd_input_defaults, $ispconfig_logarchive::fluentd_proftpd_tls_input_opts)

  fluentd::configfile { 'proftpd': }
  fluentd::configfile { 'proftpd_tls': }

  fluentd::source { 'proftpd_main':
    configfile  => 'proftpd',
    type        => 'tail',
    format      => 'syslog',
    tag         => "${ispconfig_logarchive::destination}.proftpd.log",
    config      => $input_opts,
    notify      => Class['fluentd::service']
  }

  fluentd::source { 'proftpd_tls_main':
    configfile  => 'proftpd_tls',
    type        => 'tail',
    format      => 'syslog',
    tag         => "${ispconfig_logarchive::destination}.proftpd_tls.log",
    config      => $tls_input_opts,
    notify      => Class['fluentd::service']
  }

  create_resources("ispconfig_logarchive::fluentd::${ispconfig_logarchive::destination}::proftpd",{'proftpd' => {'custom_config' => $ispconfig_logarchive::fluentd_proftpd_output_opts}})
  create_resources("ispconfig_logarchive::fluentd::${ispconfig_logarchive::destination}::proftpd_tls",{'proftpd_tls' => {'custom_config' => $ispconfig_logarchive::fluentd_proftpd_tls_output_opts}})

}
