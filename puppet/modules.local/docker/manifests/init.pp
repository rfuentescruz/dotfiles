class docker {
    include apt

    apt::key { 'docker':
        id => '58118E89F3A912897C070ADBF76221572C52609D',
        source => 'https://apt.dockerproject.org/gpg'
    }
    apt::source { 'docker':
        location => 'https://apt.dockerproject.org/repo/',
        release => "ubuntu-${::os['distro']['codename']}",
        repos => 'main',
        notify => Exec['apt_update']
    }

    package { 'docker-engine':
        provider => 'apt',
        ensure => 'present'
    }

    group { 'docker':
        ensure => 'present'
    }
}
