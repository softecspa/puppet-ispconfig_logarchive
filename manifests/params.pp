class ispconfig_logarchive::params {

  $fluentd_buffer_path  = '/var/log/td-agent/buffer'
  $s3_path              = "logs/${cluster}/${::hostname}"
  $destinations = [ 's3' ]
  $data_collectors = [ 'fluentd' ]


  ### APACHE2 ###########################
  $apache2_fluentd_input_defaults = {
    'path'      => '/var/log/httpd/ispconfig_access_log',
    'pos_file'  => '/var/tmp/apache2_fluentd.pos',
  }

  $apache2_fluentd_output_defaults = {
    'buffer_type'         => 'memory',  # tiene i log di apache in RAM per evitare I/O
    'buffer_chunk_limit'  => '64m',     # Se la RAM occupata arriva a questa dimensione, flusha
    'time_slice_format'   => '%Y%m%d%H',# Flusha con formato orario. In assenza di flush_interval questo valore indica anche ogni quanto flushare (http://docs.fluentd.org/articles/buffer-plugin-overview#time-sliced-plugin-overview)
    'flush_interval'      => '15m',      # Flusha ogni 15 minuti o al raggiungimento di buffer_chunk_limit
  }
  #######################################

  ### POSTFIX ###########################
  $mail_fluentd_input_defaults = {
    'path'      => '/var/log/mail.log',
    'pos_file'  => '/var/tmp/mail_fluentd.pos',
  }

  $mail_fluentd_output_defaults = {
    'buffer_type'         => 'memory',  # tiene i log di apache in RAM per evitare I/O
    'buffer_chunk_limit'  => '64m',     # Se la RAM occupata arriva a questa dimensione, flusha
    'time_slice_format'   => '%Y%m%d%H',# Flusha con formato orario. In assenza di flush_interval questo valore indica anche ogni quanto flushare (http://docs.fluentd.org/articles/buffer-plugin-overview#time-slice>
    'flush_interval'      => '15m',     # Flusha ogni 15 minuti o al raggiungimento di buffer_chunk_limit
  }
  #######################################

  ### PROFTPD ###########################
  $proftpd_fluentd_input_defaults = {
    'path'      => '/var/log/proftpd/proftpd.log',
    'pos_file'  => '/var/tmp/proftpd_fluentd.pos',
  }

  $proftpd_tls_fluentd_input_defaults = {
    'path'      => '/var/log/proftpd/tls.log',
    'pos_file'  => '/var/tmp/proftpd_tls_fluentd.pos',
  }

  $proftpd_fluentd_output_defaults  = {
    'buffer_type'         => 'file',                              # tiene i log in un buffer su file
    'buffer_path'         => "${fluentd_buffer_path}/s3_proftpd", # path del file buffer
    'time_slice_format'   => '%Y%m%d%H',                          # flusha con cadenza oraria
    'time_slice_wait'     => '5m',                                # aspetta per 5m eventuali log "ritardatari"
    'buffer_chunk_limit'  => '32m',                               # Se i file raggiungono questa dimensione li flusha
  }

  $proftpd_tls_fluentd_output_defaults  = {
    'buffer_type'         => 'file',                                  # tiene i log in un buffer su file
    'buffer_path'         => "${fluentd_buffer_path}/s3_proftpd_tls", # path del file buffer
    'time_slice_format'   => '%Y%m%d%H',                              # flusha con cadenza oraria
    'time_slice_wait'     => '5m',                                    # aspetta per 5m eventuali log "ritardatari"
    'buffer_chunk_limit'  => '32m',                                   # Se i file raggiungono questa dimensione li flusha
  }
  #######################################

  ### AUTH ##############################
  $auth_fluentd_input_defaults = {
    'path'      => '/var/log/auth.log',
    'pos_file'  => '/var/tmp/auth_fluentd.pos',
  }

  $auth_fluentd_output_defaults  = {
    'buffer_type'         => 'file',                              # tiene i log in un buffer su file
    'buffer_path'         => "${fluentd_buffer_path}/s3_auth",    # path del file buffer
    'time_slice_format'   => '%Y%m%d%H',                          # flusha con cadenza oraria
    'time_slice_wait'     => '5m',                                # aspetta per 5m eventuali log "ritardatari"
    'buffer_chunk_limit'  => '32m',                               # Se i file raggiungono questa dimensione li flusha
  }
  #####################################

  ### PUPPET###########################
  $puppet_fluentd_input_defaults = {
    'path'      => '/var/log/puppet/puppet-run.log',
    'pos_file'  => '/var/tmp/puppet-run_fluentd.pos',
  }

  $puppet_fluentd_output_defaults  = {
    'buffer_type'         => 'file',                              # tiene i log in un buffer su file
    'buffer_path'         => "${fluentd_buffer_path}/s3_puppet-run",    # path del file buffer
    'time_slice_format'   => '%Y%m%d%H',                          # flusha con cadenza oraria
    'time_slice_wait'     => '50m',                               # aspetta per 5m eventuali log "ritardatari"
    'buffer_chunk_limit'  => '32m',                               # Se i file raggiungono questa dimensione li flusha
  }
  #####################################

}
