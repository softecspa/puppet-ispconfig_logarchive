define ispconfig_logarchive::fluentd::s3::mail (
  $custom_config,
) {

  $s3_settings = {
    'aws_key_id'  => $ispconfig_logarchive::aws_access_key,
    'aws_sec_key' => $ispconfig_logarchive::aws_secret_key,
    's3_bucket'   => $ispconfig_logarchive::s3_logarchive_bucket,
    's3_endpoint' => $ispconfig_logarchive::s3_bucket_endpoint,
    'path'        => "logs/${cluster}/${::hostname}/mail/"
  }

  $default_config = merge ($ispconfig_logarchive::params::mail_fluentd_output_defaults,$s3_settings)
  $config         = merge ($default_config,$custom_config)

  fluentd::match{'mail_main':
    configfile  => 'mail',
    type        => 's3',
    pattern     => 's3.mail.*',
    config      => $config,
    notify => Class['fluentd::service']
  }
}
