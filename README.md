puppet-selfsigncert
===================

Puppet code to generate self sign certificates


Creating a self sign cert & key
--------------------------------

Creating a self sign certificate it's easy, script asumes (in defaults.pp) defaults for as much as it can.
Only required arguments are: domain, email, key_filename, pem_filename

```puppet
include selfsigncert

$selfcert_key = "/etc/ssl-${fqdn}.key"
$selfcert_pem = "/etc/ssl-${fqdn}.pem"

selfsigncert::create { "mydomain-example" :
	domain       => 'exampledomain.com',
	email        => 'webmaster@exampledomain.com',
	key_filename => $selfcert_key,
	pem_filename => $selfcert_pem
}
```


Using it with Nginx
-------------------

Using the above created certificate with puppet-nginx from https://github.com/jfryman/puppet-nginx

```
# Create a website address
nginx::resource::vhost { "$fqdn" :
	server_name => [ $fqdn ],
	ensure      => enable,
	www_root    => "/var/www/${fqdn}",
	ssl         => 'true',
	ssl_key     => $selfcert_key,
	ssl_cert    => $selfcert_pem,
	require     => Selfsigncert::Create["mydomain-example"]
}
```
