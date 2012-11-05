#
# Class to generate self signed certificate.
#
# This will create a self signed certificate ready to use on apache/nginx ssl configurations.
#
class selfsigncert() { 
	
	package { 'openssl' 
		ensure => present
	}
}