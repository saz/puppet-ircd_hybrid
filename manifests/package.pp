# Class: ircd_hybrid::package
#
# Description
#   This class is designed to install the packages for IRC
#   Packages are controlled via the Params class on a per-OS basis.
#
# Parameters:
#   This class takes no parameters
#
# Actions:
#   This class installs IRC packages.
#
# Requires:
#   This module has no requirements.   
#
# Sample Usage:
#   This method should not be called directly.
class ircd_hybrid::package {
  package { $ircd_hybrid::params::ic_packages: 
    ensure => present
  }
}
