
file { '/etc/motd':
  source => "/vagrant/files/etc/motd",
  owner => "root",
  group => "root",
  mode => 644
}

file { '/etc/network/if-up.d/rlbuild-bidon':
  source => "/vagrant/files/etc/network/if-up.d/rlbuild-bidon",
  owner => "root",
  group => "root",
  mode => 755
}

exec { "ipv6_network_bidon_ca":
    command => "/etc/network/if-up.d/rlbuild-bidon",
    path    => "/sbin/:/bin/:/usr/bin/",
}

