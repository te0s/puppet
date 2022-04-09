node default {
}

node 'master.puppet' {
   file { '/root/README':
      ensure => absent,
      }
}

node 'slave1.puppet' {
   class { 'apache': }
   
   file { '/root/README':
      ensure => absent,
      }
   
   file { '/var/www/html/index.html':
      ensure => file,
      source => 'https://raw.githubusercontent.com/te0s/hometask_new/main/sites/01-demosite-static/index.html',
      replace => false,
      }
}

node 'slave2.puppet' {
   class { 'apache::mod::php': }
   
   class { 'php': }
   
   file { '/root/README':
      ensure => absent,
      }
   
   file { '/var/www/html/index.php':
      ensure => file,
      source => 'https://raw.githubusercontent.com/te0s/hometask_new/main/sites/01-demosite-php/index.php',
      replace => false,
      }
}

