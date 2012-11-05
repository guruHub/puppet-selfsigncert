#
# Class to generate self signed certificate.
#
# This will create a self signed certificate ready to use on apache/nginx ssl configurations.
#
class selfsigncert() { 
	
	include selfsignecert::defaults

	if $::operatingsystem != 'Debian' {
		alert("Class selfsigncert was not tested on '${::operatingystem}'")
	}

	package { 'openssl' :
		ensure => present
	}



	define create(
		$valid_days   = $::selfsigncert::valid_days,
		$country      = $::selfsigncert::country,
		$state        = $::selfsigncert::state,
		$city         = $::selfsigncert::city,
		$organization = $::selfsigncert::organization,
		$section      = $::selfsigncert::section,
		$workpath     = $::selfsigncert::workpath,
		$key_filename,
		$domain,
		$email
	) {

		file{ "/usr/local/bin/selfsigncert-${domain}.sh" : 
			ensure  => present,
			content => template('selfsigncert/selfsigncert.sh.erb'),
			owner   => root,
			group   => root,
			mode    => 500
		}
		# The above file{} will be created on each call so if you ask: if you call this on a server with 
		# 300 domains, it will upload 300 times the same file with a different name to create the cert. 
		# However, if you plan hosting 300 ssl domains with their respective IP in the same server, I bet 
		# you know what you are doing and can deal with it.
		# 
		# Run the script to generate the pem file
		exec{ "selfsign_${name}" :
			command => "/usr/local/bin/selfsigncert-${domain}.sh", 
			path    => '/usr/bin:/bin',
			unless  => 'test -f $key_filename',
			require => File["/usr/local/bin/selfsigncert-${domain}.sh"],
		}
	}

}
