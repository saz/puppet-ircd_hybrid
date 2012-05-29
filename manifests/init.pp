# Class: ircd_hybrid
#
# Description
#   This module is designed to install and manage IRC Hybrid, an IRC server
#
#   This module has been built and tested on RHEL systems.
#
# Parameters:
#  $network_name: The FQDN of the host where this server will reside.
#  $network_desc: A friendly descriptor of the IRC server
#  $admin_name: Friendly name of the Admin of the IRC server
#  $admin_email: Email address of the Admin
#  $listen_ip: Default IP for IRCD to listen on. Defaults to 127.0.0.1 if not set.
#  $auth_domains: domains that are authorized to be in the local user class.
#  $spoof_domain: domain used to spoof users that do not have domains.
#  $operator_name: admin account for IRC management
#  $operator_pass: admin password for IRC management. 
#   
# Actions:
#   This module will install a single IRC and configure it for usage. 
#
# Requires:
#  - Class[stdlib]. This is Puppet Labs standard library to include additional methods for use within Puppet. [https://github.com/puppetlabs/puppetlabs-stdlib]
# 
# Sample Usage:
#  class { 'irc':
#    network_name  => 'irc.frymanandassociates.net',
#    network_desc  => 'Fryman and Associates, Inc - IRC Server',
#    admin_name    => 'James Fryman',
#    admin_email   => 'james@frymanandassociates.net',
#    listen_ip     => '127.0.0.1',
#    auth_domains  => ['frymanandassociates.net', 'frymanet.com'],
#    spoof_domain  => 'frymanandassociates.net',
#    operator_name => 'admin',
#    operator_pass => 'password',
#  }
class ircd_hybrid(
  $network_name  = $ircd_hybrid::params::ic_network_name,
  $network_desc  = $ircd_hybrid::params::ic_network_desc,
  $admin_name    = $ircd_hybrid::params::ic_admin_name,
  $admin_email   = $ircd_hybrid::params::ic_admin_email,
  $listen_ip     = $ircd_hybrid::params::ic_listen_ip,
  $listen_port   = $ircd_hybrid::params::ic_listen_port,
  $auth_domains  = $ircd_hybrid::params::ic_auth_domains,
  $spoof_domain  = $ircd_hybrid::params::ic_spoof_domain,
  $operator_name = $ircd_hybrid::params::ic_operator_name,
  $operator_pass = $ircd_hybrid::params::ic_operator_pass,
  $module_paths  = $ircd_hybrid::params::ic_module_paths,
  $modules       = $ircd_hybrid::params::ic_modules
) inherits ircd_hybrid::params {
  include stdlib

  package { $ircd_hybrid::params::ic_packages: 
    ensure => present
  }

  file { "${ircd_hybrid::params::ic_conf_dir}/ircd.conf":
    ensure  => file,
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    content => template("${module_name}/ircd.conf.erb"),
    require => Package[$ircd_hybrid::params::ic_packages],
  }

  service { $ircd_hybrid::params::ic_daemon:
    ensure     => 'running',
    enable     => 'true',
    hasstatus  => false,
    hasrestart => true,
    pattern    => $ircd_hybrid::params::ic_pattern,
  }
}
