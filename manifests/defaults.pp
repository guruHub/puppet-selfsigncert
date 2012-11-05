#
# Default values for self signed certificates requests
#
class selfsigncert::defaults() {
	# Default valid days for cert
	$valid_days   = '3650'
	$country      = 'US'
	$state        = 'Somewhere State'
	$city         = 'Somewhere City'
	$organization = 'Some Organization'
	$section      = 'Some Section'
	$workpath     = '/root'
	$leave_only_key  = true
}