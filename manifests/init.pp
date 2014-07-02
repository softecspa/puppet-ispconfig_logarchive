# == Class ispconfig_logarchive
#
# This class manage log archiviation using a data-collector, like fluentd or logstash, for a ispconfig managed server.
#
# === Parameters
# [*data_collector*]
#   Data collector to use. Actually only fluentd is supported and it's the default
#
# [*destination*]
#   Destination of logs. Actually only s3 is supported and it's the default
#
# [*aws_access_key*]
#   Used only if destination=s3. AWS access key. Default: global variable $::aws_access_key
#
# [*aws_secret_key*]
#   Used only if destination=s3. AWS secret key. Default: global variable $::aws_secret_key
#
# [*s3_bucket_name*]
#   Used only if destination=s3. S3 bucket name to archive logs. Default: global variable $::s3_logarchive_bucket
#
# [*s3_bucket_endpoint*]
#   Used only if destination=s3. S3 bucket endpoint. Default: global variable $::s3_bucket_endpoint
#
# [*s3_logpath*]
#   Used only if destination=s3. Path prefix used to archive logs. Default: logs/${cluster}/${::hostname}/
#
# [*apache2*]
#   If true, module will manage apache2 access_log in ispconfig path. Default: true
#
# [*proftpd*]
#   If true, module will manage proftpd access_log and tls.log in ispconfig path. Default: true
#
# [*mail*]
#   If true, module will manage mail.log in ispconfig path. Default: true
#
# [*auth*]
#   If true, module will manage auth.log. Default: true
#
# [*puppet*]
#   If true, module will manage puppet-run log. Default: true
#
# [*fluentd_apache2_input_opts*]
#   hash used to pass configuration at source level for apache2 log management with a fluentd data collector. This hash will be merged with, and override, the default (see README)
#
# [*fluentd_apache2_output_opts*]
#   hash used to pass configuration at destination level for apache2 log management with a fluentd data collector. This hash will be merged with, and override, the default (see README)
#
# [*fluentd_proftpd_input_opts*]
#   hash used to pass configuration at source level for proftpd.log management with a fluentd data collector. This hash will be merged with, and override, the default (see README)
#
# [*fluentd_proftpd_output_opts*]
#   hash used to pass configuration at destination level for proftpd.log management with a fluentd data collector. This hash will be merged with, and override, the default (see README)
#
# [*fluentd_proftpd_tls_input_opts*]
#   hash used to pass configuration at source level for proftpd tls.log management with a fluentd data collector. This hash will be merged with, and override, the default (see README)
#
# [*fluentd_proftpd_tls_output_opts*]
#   hash used to pass configuration at destination level for proftpd tls.log management with a fluentd data collector. This hash will be merged with, and override, the default (see README)
#
# [*fluentd_mail_input_opts*]
#   hash used to pass configuration at source level for mail.log management with a fluentd data collector. This hash will be merged with, and override, the default (see README)
#
# [*fluentd_mail_output_opts*]
#   hash used to pass configuration at destination level for mail.log management with a fluentd data collector. This hash will be merged with, and override, the default (see README)
#
# [*fluentd_auth_input_opts*]
#   hash used to pass configuration at source level for auth.log management with a fluentd data collector. This hash will be merged with, and override, the default (see README)
#
# [*fluentd_auth_output_opts*]
#   hash used to pass configuration at destination level for auth.log management with a fluentd data collector. This hash will be merged with, and override, the default (see README)
#
# [*fluentd_puppet_input_opts*]
#   hash used to pass configuration at source level for puppet-run.log management with a fluentd data collector. This hash will be merged with, and override, the default (see README)
#
# [*fluentd_puppet_output_opts*]
#   hash used to pass configuration at destination level for auth.log management with a fluentd data collector. This hash will be merged with, and override, the default (see README)
#
# === Examples
# 1) simply manage all manageable logs with default configs
#
#   node foo.example.com {
#     include ispconfig_logarchive
#   }
#
# 2) exclude puppet logs management
#   node foo.example.com {
#     class {'ispconfig_logarchive':
#       puppet  => false
#     }
#   }
#
# 3) Override mail.log source path in fluentd
#   node foo.example.com {
#     class {'ispconfig_logarchive':
#       fluentd_mail_input_opts => { 'path' => '/path/to/mail.log'
#     }
#   }
#
# 4) Override mail.log flush_interval in fluentd
#   node foo.example.com {
#     class {'ispconfig_logarchive':
#       fluentd_mail_output_opts => { 'flush_interval' => '30m' }
#     }
#   }
#
class ispconfig_logarchive (
  $data_collector                 = 'fluentd',
  $destination                    = 's3',
  $aws_access_key                 = $::aws_access_key,
  $aws_secret_key                 = $::aws_secret_key,
  $s3_bucket_name                 = $::s3_logarchive_bucket,
  $s3_bucket_endpoint             = $::s3_bucket_endpoint,
  $s3_logpath                     = "logs/${cluster}/${::hostname}/",
  $apache2                        = true,
  $proftpd                        = true,
  $mail                           = true,
  $auth                           = true,
  $puppet                         = true,
  $fluentd_apache2_input_opts     = {},
  $fluentd_apache2_output_opts    = {},
  $fluentd_proftpd_input_opts     = {},
  $fluentd_proftpd_output_opts    = {},
  $fluentd_proftpd_tls_input_opts = {},
  $fluentd_proftpd_tls_output_opts= {},
  $fluentd_mail_input_opts        = {},
  $fluentd_mail_output_opts       = {},
  $fluentd_auth_input_opts        = {},
  $fluentd_auth_output_opts       = {},
  $fluentd_puppet_input_opts      = {},
  $fluentd_puppet_output_opts     = {},

) inherits ispconfig_logarchive::params {

  if !($data_collector in $ispconfig_logarchive::params::data_collectors) {
    fail("$data_collector is not actually supported")
  }

  if !($destination in $ispconfig_logarchive::params::destinations) {
    fail("$destination is not actually supported")
  }

  class {"ispconfig_logarchive::${data_collector}::install": }

  if $apache2 {
    class {"ispconfig_logarchive::${data_collector}::apache2":}
  }

  if $proftpd {
    class {"ispconfig_logarchive::${data_collector}::proftpd":}
  }

  if $mail {
    class {"ispconfig_logarchive::${data_collector}::mail":}
  }

  if $auth {
    class {"ispconfig_logarchive::${data_collector}::auth":}
  }

  if $puppet {
    class {"ispconfig_logarchive::${data_collector}::puppet":}
  }

}
