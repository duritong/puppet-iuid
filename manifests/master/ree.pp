# Class: iuid::master::ree
#
# This module manages the necessary things for iuid on a master.
#
# [Remember: No empty lines between comments and class definition]
class iuid::master::ree {

  require ruby-enterprise::gems::moneta
  
  ruby-enterprise::gem{'iuid': }
}
