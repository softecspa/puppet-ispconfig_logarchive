define ispconfig_logarchive::fluentd::s3::apache2 (
  $custom_config,
) {

  $s3_settings = {
    'aws_key_id'  => $ispconfig_logarchive::aws_access_key,
    'aws_sec_key' => $ispconfig_logarchive::aws_secret_key,
    's3_bucket'   => $ispconfig_logarchive::s3_logarchive_bucket,
    's3_endpoint' => $ispconfig_logarchive::s3_bucket_endpoint,
    'path'        => "logs/${cluster}/${::hostname}/apache2/"
  }

  $default_config = merge ($ispconfig_logarchive::params::apache2_fluentd_output_defaults,$s3_settings)
  $config         = merge ($default_config,$custom_config)

  fluentd::match{'apache2_main':
    configfile  => 'apache2',
    type        => 's3',
    pattern     => 's3.apache.*',
    config      => $config,
    notify => Class['fluentd::service']
  }
}
