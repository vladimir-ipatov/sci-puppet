class approx {

	package { 'approx': ensure => installed, allowcdrom => true } 

	file { "/etc/approx/approx.conf":
		owner => "root",
		group => "root",
		mode => 0644,
		content => template("approx/approx.conf.erb"),
		require => Package['approx'],
	}
}

# approx part to deploy the local repos and cd-rom
class approx_local {
	include approx
	$GPGDir = "/etc/sci/gpg"
	$Release = "/media/sci/dists/$lsbdistcodename/Release"
	$approxModule = "/etc/puppet/modules/approx"

	file { "/etc/sci":
		owner => "root",
		group => "root",
		mode => 0755,
		ensure => [directory, present],
	}
	file { "$GPGDir":
		owner => "root",
		group => "root",
		mode => 0700,
		ensure => [directory, present],
	}
	file { "$GPGDir/sci-genkey.sh":
		owner => "root",
		group => "root",
		mode => 0700,
		source => 'puppet:///modules/approx/sci-genkey.sh',
		require => File["$GPGDir"],
	}
	file { "$GPGDir/sci-key-input":
		owner => "root",
		group => "root",
		mode => 0700,
		content => template("approx/sci-key-input.erb"),
		require => File["$GPGDir"],
	}
	file { "$GPGDir/sci.pub": }
	exec { approx_gen_key:
		command => "$GPGDir/sci-genkey.sh",
		creates => "$GPGDir/sci.pub",
		require => File["$GPGDir/sci-key-input"],
	}
	file { "$Release": }
	file { "$Release.gpg": }
	file { "$GPGDir/secring.gpg": }
	file { "$approxModule/files/sci.pub": }
	exec { approx_sign_local_release:
		command => "/usr/bin/gpg --homedir $GPGDir --sign -abs -o $Release.gpg $Release",
		creates => "$Release.gpg",
		require => [Exec["approx_gen_key"], File["$GPGDir/sci.pub", "$Release"]],
	}
	exec { approx_publish_key:
		command => "/bin/cp $GPGDir/sci.pub /etc/puppet/modules/approx/files/sci.pub",
		creates => "/etc/puppet/modules/approx/files/sci.pub",
		require => [Exec["approx_sign_local_release"], File["$GPGDir/sci.pub", "$Release.gpg"]],
	}
}

# sources.list with apt key for local repos
class sources_list($local_sources=yes) {
	if $local_sources == yes {
		if defined(File['/etc/sci']) == false {
		file { "/etc/sci":
			owner => "root",
			group => "root",
			mode => 0755,
			ensure => [directory, present],
			}
		}

		file { "/etc/sci/sci.pub":
			owner => "root", group => "root", mode => 0644,
			source => 'puppet:///modules/approx/sci.pub',
			require => File["/etc/sci"],
		}
		exec { apt-key-add-sci:
			command => "/usr/bin/apt-key add /etc/sci/sci.pub",
			require => File["/etc/sci/sci.pub"],
			subscribe => File["/etc/sci/sci.pub"],
			notify => Exec["apt-get-update"],
			refreshonly => true,
		}
	}

	if $operatingsystem == "Debian" {
		if $lsbdistcodename == "squeeze" {
			file { "/etc/apt/sources.list":
				owner => "root", group => "root", mode => 0644,
				content => template("approx/sources.list.squeeze.erb"),
			}
		} else {
			file { "/etc/apt/sources.list":
				owner => "root", group => "root", mode => 0644,
				content => template("approx/sources.list.erb"),
			}
		}

	}
	if $operatingsystem == "Ubuntu" {
		file { "/etc/apt/sources.list":
			owner => "root", group => "root", mode => 0644,
			content => template("approx/sources.list.ubuntu.erb"),
		}
	}
	file { "/etc/apt/apt.conf.d/11periodic":
		owner => "root", group => "root", mode => 0644,
		source => 'puppet:///modules/approx/11periodic',
	}
	file { "/etc/apt/apt.conf.d/99stable":
		owner => "root", group => "root", mode => 0644,
		source  => $lsbdistcodename ? {
			'squeeze' => 'puppet:///modules/approx/99stable.squeeze',
			'wheezy' => 'puppet:///modules/approx/99stable.wheezy',
			'jessie' => 'puppet:///modules/approx/99stable.jessie',
			'lenny' => 'puppet:///modules/approx/99stable.lenny',
			'precise' => 'puppet:///modules/approx/99stable.precise',
			'trusty' => 'puppet:///modules/approx/99stable.trusty',
			default => 'puppet:///modules/approx/99stable.wheezy',
		},
	}
	if $local_sources == yes {
		exec{ apt-get-update:
			command => '/usr/bin/apt-get update',
			refreshonly => true,
			require => File["/etc/sci/sci.pub"],
			subscribe => File['/etc/apt/sources.list'],
		}
	} else {
		exec{ apt-get-update:
			command => '/usr/bin/apt-get update',
			refreshonly => true,
			subscribe => File['/etc/apt/sources.list'],
		}
	}
}

# workaround for http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=655986
class approx_fix_cache {
	if defined(Package['approx']) == true {
		exec {'fix-approx-cache':
			command => '/usr/bin/find /var/cache/approx -empty -type f -perm 0000 -delete; /usr/bin/find /var/cache/approx -mindepth 1 -empty -type d -delete; echo "43 3 * * * root find /var/cache/approx -empty -type f -perm 0000 -delete; find /var/cache/approx -mindepth 1 -empty -type d -delete" > /etc/cron.d/approx-fix-cache',
			creates => '/etc/cron.d/approx-fix-cache',
		}
	}
}
