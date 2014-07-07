puppet-ispconfig\_logarchive
===========================

manage long-term archiving of service's logs in IspConfig environment using a data collector

####Table of Contents

1. [Overview](#overview)
2. [Module Description - What the module does and why it is useful](#module-description)
3. [Setup - The basics of getting started with [Modulename]](#setup)
 * [Setup requirements](#setup-requirements)
4. [Usage - Configuration options and additional functionality](#usage)
 * [Default config options](#default-config-options)
5. [Limitations - OS compatibility, etc.](#limitations)

##Overview
This module use a data collector service to archive service's logs. It's configured to manage log files in a IspConfig environment.

##Module Description
Module is structured to use various data collectors and destinations. Actually only **fluentd** data collector and **s3** destination plugin are available.

##Setup
    include ispconfig_logarchive

###Setup Requirements
if used data\_collector is fluentd it requires
 * softecspa/puppet-fluentd module

if destination is s3 and aws/s3 parameters are not passed, default will be taken from global variables:
 * $::aws\_access\_key,
 * $::aws\_secret\_key
 * $::s3\_logarchive\_bucket,
 * $::s3\_bucket\_endpoint,

if destination is s3 and s3\_logpath is not passed, default value will use $cluster variable:
    * logs/${cluster}/${::hostname}/

##Usage
Each config parameter for each managed logfile can be defined or overrided passing an hash to the relative class parameter:
 * $datacollector\_$servicename\_$(input|output)\_opts

Ex1: if you want to define or override config parameter for apache2 log source in fluentd, you can do this using the hash parameter:
 * fluentd\_apache2\_input\_opts

Ex2: if you want to define or override config parameter for apache2 log destination in fluentd, you can do this using the hash parameter:
 * fluentd\_apache2\_output\_opts

### Default config options
This  are the default config options passed by default:
 * apache2
  * input
   * bbb

## Limitations
Actually only **fluentd** data collector and **s3** destination plugin are available
