node default {
}

node 'master.puppet' {

Include nginx

nginx::resource::server { 'static':
  listen_port => 80,
  proxy => 'http://192.168.56.101:80',
  }

nginx::resource::server { 'dynamic':
  listen_port => 81,
  proxy => 'http://192.168.56.102:80',
  }


exec { 'selinux_to_permissive':
  command     => 'setenforce 0',
  path        => [ '/usr/bin', '/bin', '/usr/sbin' ],
  user       => 'root',
  }

exec { 'reboot_nginx':
  command     => 'systemctl restart nginx',
  path        => [ '/usr/bin', '/bin', '/usr/sbin' ],
  user => 'root',
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


node 'mine' {
  include minecraft
}
