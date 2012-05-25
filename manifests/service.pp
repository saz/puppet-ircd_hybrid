# Class: ircd_hybrid::service
#
# This module manages irc service management
#
# Parameters:
#
# There are no default parameters for this class.
#
# Actions:
#
# Requires:
#
# Sample Usage:
#
# This class file is not called directly
class ircd_hybrid::service {
  service { $ircd_hybrid::params::ic_daemon:
    ensure => 'running',
    enable => 'true',
  }
}
