# config for uid
class iuid::config(
  $categories = {},
  $edit_uid   = 'puppet',
  $datafile   = "${settings::confdir}/iuid_data.yaml"
) {
  require iuid::master

  # deploy default config file and link it for iuid cli lookup
  file{
    "${settings::confdir}/iuid.yaml":
      content => template('iuid/iuid.yaml.erb'),
      owner   => 'root',
      group   => $edit_uid,
      mode    => '0640';
    '/etc/iuid.yaml':
      ensure  => link,
      target  => "${settings::confdir}/iuid.yaml";
    $datafile:
      ensure  => present,
      owner   => $edit_uid,
      group   => 0,
      mode    => '0600';
  }
}
