#
# Class to generate self signed certificate.
#
# This will create a self signed certificate ready to use on apache/nginx ssl configurations.
#
class selfsigncert() { 
	
	include selfsigncert::defaults

	if $::operatingsystem != 'Debian' {
		alert("Class selfsigncert was not tested on '${::operatingystem}'")
	}

	package { 'openssl' :
		ensure => present
	}



	file{ "/usr/local/bin/selfsigncert.sh" : 
		ensure  => present,
		source => 'puppet:///selfsigncert/selfsigncert.sh',
		owner   => root,
		group   => root,
		mode    => 500
	}

	define create(
		$valid_days   = $::selfsigncert::defaults::valid_days,
		$country      = $::selfsigncert::defaults::country,
		$state        = $::selfsigncert::defaults::state,
		$city         = $::selfsigncert::defaults::city,
		$organization = $::selfsigncert::defaults::organization,
		$section      = $::selfsigncert::defaults::section,
		$workpath     = $::selfsigncert::defaults::workpath,
		$key_filename,
		$pem_filename,
		$domain,
		$email
	) {
		# The above file{} will be created on each call so if you ask: if you call this on a server with 
		# 300 domains, it will upload 300 times the same file with a different name to create the cert. 
		# However, if you plan hosting 300 ssl domains with their respective IP in the same server, I bet 
		# you know what you are doing and can deal with it.
		# 
		# Run the script to generate the pem file
		exec{ "selfsign_${name}" :
			command => "/usr/local/bin/selfsigncert.sh \"${valid_days}\" \"${country}\" ",
			path    => '/usr/bin:/bin',
			unless  => 'test -f $key_filename && test -f $pem_filename',
			require => File["/usr/local/bin/selfsigncert.sh"],
		}
	}

}
