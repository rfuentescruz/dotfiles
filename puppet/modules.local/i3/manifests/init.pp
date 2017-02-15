class i3 {
    include apt

    apt::source { 'i3':
        location => 'http://debian.sur5r.net/i3/',
        release => 'xenial',
        repos => 'universe',
        notify => Exec['apt_update']
    }

    package { 'sur5r-keyring':
        provider => 'apt',
        install_options => ['--allow-unauthenticated'],
        notify => Exec['apt_update']
    }

    package { 'i3':
        ensure => 'present',
        require => [
            Apt::Source['i3'],
            Package['sur5r-keyring']
        ]
    }
}
