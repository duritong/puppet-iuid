# Class: iuid::master
#
# This module manages the necessary things for iuid on a master.
#
# [Remember: No empty lines between comments and class definition]
class iuid::master {

  require rubygems::moneta

  package{'iuid':
      ensure   => present,
      provider => gem,
  }
}
