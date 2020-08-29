# Class: iuid::master
#
# This module manages the necessary things for iuid on a master.
#
# [Remember: No empty lines between comments and class definition]
class iuid::master(
  Boolean $manage_dependencies = true,
) {
  if $manage_dependencies {
    package{'rubygem-iuid':
      ensure   => present,
    }
  }
}
