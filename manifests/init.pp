
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

exec { "bidon_ca_ipv6_network":
    command => "/etc/network/if-up.d/rlbuild-bidon",
    path    => "/sbin/:/bin/:/usr/bin/",
}

package { "git":
    ensure => "installed"
}

package { "rsync":
    ensure => "installed"
}

fstab { 'for rlbuild image publication to web':
    source => 'damas.net4.bidon.ca:/home/bgm/media-public/reseaulibre-openwrt/images',
    dest   => '/mnt',
    type   => 'nfs',
    opts   => 'defaults,noatime,nofail,rw,nolock,soft,nfsvers=3',
    dump   => 0,
    passno => 1,
}

exec { "bidon_ca_mnt_point":
    command => "mount /mnt || echo 'ignoring error'",
    path    => "/sbin/:/bin/:/usr/bin/",
}

group { 'jenkins':
    ensure => 'present',
    gid    => 1008,
}

user { 'jenkins':
    ensure => 'present',
    uid    => 1008,
    gid    => 1008,
}

file { "/home/jenkins/":
    ensure => 'directory',
    require => User['jenkins'],
    owner => 'jenkins',
    group => 'jenkins',
    mode => '700',
}

file { "/home/jenkins/.ssh":
    ensure => 'directory',
    require => User['jenkins'],
    owner => 'jenkins',
    group => 'jenkins',
    mode => '700',
}

# http://reductivelabs.com/trac/puppet/wiki/TypeReference#ssh-authorized-key
ssh_authorized_key { "jenkins-rsa-key":
    ensure => 'present',
    key => 'AAAAB3NzaC1yc2EAAAADAQABAAABAQDX1t31hGVHeIVoTpN1hg3l2AAAaGFHSqrg7okFSuI3KGYZEFYfVXQYSKiLDp0dIGZI1mZewK5Ru6EWxW9dYWVcqIE4HMuwylOTlL6NuipqXT2LL66XxQQ0Tn+qYqcvabqUg+qs2JoM2fQowqkg1hBMw3BQfX3K6eUIehhqmAYJ7a82icXC5w84qoOeGkS1DRiEXD/fLJll04A55J3L7GJuS7V0MPfZLAdp5bjeKdSJKiaV/ZFBx0/hYZ5ASDkDk49PDVDyrjCPJAmNZtxL7CDm0aaT1S7XnqciCIbOyLuhBGbrIo3eDDSgym1G0GTITe4fRr78KewKq7VGjOqCvr+F',
    name => 'jenkins@rlbuild',
    type => 'rsa',
    user => 'jenkins',
    require => File["/home/jenkins/.ssh"],
}

