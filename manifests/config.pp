# config for uid
class iuid::config(
  $categories = {},
) {
  require iuid::master

  # deploy default config file and link it for iuid cli lookup
  $datafile = "${settings::confdir}/iuid_data.yaml"
  file{
    "${settings::confdir}/iuid.yaml":
      content => template('iuid/iuid.yaml.erb'),
      owner   => root,
      group   => puppet,
      mode    => '0640';
    '/etc/iuid.yaml':
      ensure  => link,
      target  => "${settings::confdir}/iuid.yaml";
    $datafile:
      ensure  => present,
      owner   => puppet,
      group   => 0,
      mode    => '0600';
  }
}
