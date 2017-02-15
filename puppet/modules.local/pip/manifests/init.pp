class pip {
    file { '/tmp/get-pip.py':
        source => 'https://bootstrap.pypa.io/get-pip.py'
    }

    exec { '/usr/bin/python /tmp/get-pip.py':
        cwd => '/tmp',
        path => '/usr/bin:/usr/local/bin',
        unless => 'pip --version'
    }
}
