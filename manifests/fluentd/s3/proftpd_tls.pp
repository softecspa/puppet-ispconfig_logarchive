define ispconfig_logarchive::fluentd::s3::proftpd_tls (
  $custom_config,
) {

  $s3_settings = {
    'aws_key_id'  => $ispconfig_logarchive::aws_access_key,
    'aws_sec_key' => $ispconfig_logarchive::aws_secret_key,
    's3_bucket'   => $ispconfig_logarchive::s3_logarchive_bucket,
    's3_endpoint' => $ispconfig_logarchive::s3_bucket_endpoint,
    'path'        => "logs/${cluster}/${::hostname}/proftpd_tls/"
  }

  $default_config = merge ($ispconfig_logarchive::params::proftpd_tls_fluentd_output_defaults,$s3_settings)
  $config         = merge ($default_config,$custom_config)

  fluentd::match{'proftpd_tls_main':
    configfile  => 'proftpd_tls',
    type        => 's3',
    pattern     => 's3.proftpd_tls.*',
    config      => $config,
    notify => Class['fluentd::service']
  }
}
