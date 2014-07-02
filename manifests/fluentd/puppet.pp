class ispconfig_logarchive::fluentd::puppet {

  $input_opts     = merge($ispconfig_logarchive::params::puppet_fluentd_input_defaults, $ispconfig_logarchive::fluentd_puppet_input_opts)

  fluentd::configfile { 'puppet': }

  fluentd::source { 'puppet_main':
    configfile  => 'puppet',
    type        => 'tail',
    format      => '/^(?<time>[^ ]* [^ ]* [^ ]* [^ ]* [^ ]* [^ ]*) (?<message>.*)$/',
    time_format => '%a %b %d %H:%M:%S %z %Y',
    tag         => "${ispconfig_logarchive::destination}.puppet.log",
    config      => $input_opts,
    notify      => Class['fluentd::service']
  }

  create_resources("ispconfig_logarchive::fluentd::${ispconfig_logarchive::destination}::puppet",{'puppet' => {'custom_config' => $ispconfig_logarchive::fluentd_puppet_output_opts}})

}
