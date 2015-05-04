# PRIVATE CLASS: do not use directly
class mongodb::repo::apt inherits mongodb::repo {
  # we try to follow/reproduce the instruction
  # from http://docs.mongodb.org/manual/tutorial/install-mongodb-on-ubuntu/

  include ::apt

  if($::mongodb::repo::ensure == 'present' or $::mongodb::repo::ensure == true) {
    apt::source { 'repo.mongodb.org':
      location    => $::mongodb::repo::location,
      repos       => 'trusty/mongodb-org/3.0 multiverse',
      key         => '7F0CEB10',
      key_server  => 'hkp://keyserver.ubuntu.com:80',
      include_src => false,
    }

    Apt::Source['repo.mongodb.org']->Package<|tag == 'mongodb'|>
  }
  else {
    apt::source { 'repo.mongodb.org':
      ensure => absent,
    }
  }
}
