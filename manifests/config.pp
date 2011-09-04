class iuid::config(
  $categories = {},
  $ruby = 'system'
) {
  if $iuid::config::ruby == 'system' or $iuid::config::ruby == 'both' {
    require iuid::master
  }
  if $iuid::config::ruby == 'ree' or $iuid::config::ruby == 'both' {
    require iuid::master::ree
  }

  # deploy default config file and link it for iuid cli lookup
  $datafile = "${settings::confdir}/iuid_data.yaml"
  file{
    "${settings::confdir}/iuid.yaml":
      content => template('iuid/iuid.yaml.erb'),
      owner => root, group => puppet, mode => 0640;
    '/etc/iuid.yaml':
      ensure => link,
      target => "${settings::confdir}/iuid.yaml";
    $datafile:
      ensure => present,
      owner => puppet, group => 0, mode => 0600;
  }
}
