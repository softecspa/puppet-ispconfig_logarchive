class ispconfig_logarchive::fluentd::mail {

  $input_opts     = merge($ispconfig_logarchive::params::mail_fluentd_input_defaults, $ispconfig_logarchive::fluentd_mail_input_opts)

  fluentd::configfile { 'mail': }
  fluentd::source { 'mail_main':
    configfile  => 'mail',
    type        => 'tail',
    format      => 'syslog',
    tag         => "${ispconfig_logarchive::destination}.mail.log",
    config      => $input_opts,
    notify      => Class['fluentd::service']
  }

  create_resources("ispconfig_logarchive::fluentd::${ispconfig_logarchive::destination}::mail",{'mail' => {'custom_config' => $ispconfig_logarchive::fluentd_mail_output_opts}})

}
