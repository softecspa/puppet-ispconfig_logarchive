class ispconfig_logarchive::fluentd::apache2 {

  $input_opts = merge($ispconfig_logarchive::params::apache2_fluentd_input_defaults, $ispconfig_logarchive::fluentd_apache2_input_opts)

  fluentd::configfile { 'apache2': }
  fluentd::source { 'apache_main':
    configfile  => 'apache2',
    type        => 'tail',
    format      => '/^(?<vhost>[^|]*)\|\|\|\|(?<size>[0-9\-]*)\|\|\|\|(?<client>[^ ]*) (?<host>[^ ]*) (?<vhost>[^ ]*) (?<user>[^ ]*) \[(?<time>[^\]]*)\] "(?<method>\S+)(?: +(?<path>[^ ]*) +\S*)?" (?<code>[^ ]*) (?<size>[0-9\-]*)(?: "(?<referer>[^\"]*)" "(?<agent>[^\"]*)")? "(?<cookie>[^\"]*)" (?<serv_time_second>[0-9]*)/(?<serv_time_microsecond>[0-9]*) (?<conn_status>[X|\+|\-]?) (?<process_id>[0-9]*)$/',
    time_format => '%d/%b/%Y:%H:%M:%S %z',
    tag         => "${ispconfig_logarchive::destination}.apache.access_log",
    config      => $input_opts,
    notify      => Class['fluentd::service']
  }
  # il parametro format indica il nostro logformat

  create_resources("ispconfig_logarchive::fluentd::${ispconfig_logarchive::destination}::apache2",{'apache2' => {'custom_config' => $ispconfig_logarchive::fluentd_apache2_output_opts}})

}
