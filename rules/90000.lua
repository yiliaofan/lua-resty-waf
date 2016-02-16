-- Custom Rules

local _M = {}

_M.version = "0.6.0"

_M.rules = {
	access = {
		{
			id = 90001,
			var = {
				type = "REQUEST_HEADERS",
				opts = { key = "specific", value = "user-agent" },
				pattern = "FreeWAF Dummy",
				operator = "EQUALS"
			},
			opts = { score = 3 },
			action = "SCORE",
			description = "Dummy FreeWAF signature"
		},
		{
			id = 90002,
			var = {
				type = "URI",
				pattern = [=[^\/(?:(?:id_)?[dr]sa(?:\.old)?|key(?:\.priv)?)$]=],
				operator = "REGEX"
			},
			action = "DENY",
			description = "SSH key scan (https://isc.sans.edu/forums/diary/Gimme+your+keys+/18231)" 
		},
		{
			id = 90003,
			var = {
				type = "URI",
				pattern = "/checknfurl123",
				operator = "EQUALS"
			},
			opts = { nolog = true },
			action = "CHAIN",
		},
		{
			id = 90004,
			var = {
				type = "METHOD",
				pattern = "HEAD",
				operator = "EQUALS"
			},
			action = "DENY",
			description = "SSH key scan signature (https://isc.sans.edu/forums/diary/Gimme+your+keys+/18231)"
		},
		{
			id = 90005,
			var = {
				type = "URI",
				pattern = [=[/((?:tim)?thumb|img)\.php]=],
				operator = "REGEX"
			},
			opts = { nolog = true },
			action = "CHAIN"
		},
		{
			id = 90006,
			var = {
				type = "URI_ARGS",
				opts = { key = "keys" },
				pattern = "webshot",
				operator = "CONTAINS"
			},
			opts = { nolog = true },
			action = "CHAIN"
		},
		{
			id = 90007,
			var = {
				type = "URI_ARGS",
				opts = { key = "specific", value = "src" },
				pattern = [=[\$\(.*\)]=],
				operator = "REGEX"
			},
			action = "DENY",
			description = "Timthumb zero-day (http://seclists.org/fulldisclosure/2014/Jun/117)"
		},
		{
			id = 90008,
			var = {
				type = "URI",
				pattern = "/xmlrpc.php",
				operator = "EQUALS"
			},
			opts = { nolog = true },
			action = "CHAIN"
		},
		{
			id = 90009,
			var = {
				type = "REQUEST_HEADERS",
				opts = { key = "specific", value = "user-agent" },
				pattern = [=[WinHttp\.WinHttpRequest\.5]=],
				operator = "REGEX"
			},
			action = "DENY",
			description = "Brute force botnet affecting Wordpress domains"
		},
		{
			id = 90010,
			var = {
				type = "REQUEST_HEADERS",
				opts = { key = "specific", value = "user-agent" },
				pattern = [=[Mozilla/5\.0 \(compatible; Zollard; Linux\)]=],
				operator = "REGEX"
			},
			action = "DENY",
			description = "Known *Coin miner worm (https://isc.sans.edu/forums/diary/Multi+Platform+Coin+Miner+Attacking+Routers+on+Port+32764/18353)"
		},
		{
			id = 90011,
			var = {
				type = "URI",
				pattern = "/wp-login.php",
				operator = "EQUALS"
			},
			opts = { nolog = true },
			action = "CHAIN"
		},
		{
			id = 90012,
			var = {
				type = "URI_ARGS",
				opts = { key = "specific", value = "registration" },
				pattern = "disabled",
				operator = "EQUALS"
			},
			opts = { score = 5 },
			action = "SCORE",
			description = "Client attempted to register a Wordpress user, but user registration is disabled."
		},
		{
			id = 90013,
			var = {
				type = "URI",
				pattern = "/wp-login.php",
				operator = "EQUALS"
			},
			opts = { nolog = true },
			action = "CHAIN"
		},
		{
			id = 90014,
			var = {
				type = "METHOD",
				pattern = "POST",
				operator = "EQUALS"
			},
			opts = { nolog = true },
			action = "CHAIN"
		},
		{
			id = 90015,
			var = {
				type = "REQUEST_HEADER_NAMES",
				pattern = "referer",
				operator = "NOT_CONTAINS"
			},
			action = "DENY",
			description = "Wordpress login attempted with no Referer"
		},
		{
			id = 90016,
			var = {
				type = "URI",
				pattern = "/wp-admin/admin-ajax.php",
				operator = "EQUALS"
			},
			opts = { nolog = true },
			action = "CHAIN"
		},
		{
			id = 90017,
			var = {
				type = "URI_ARGS",
				opts = { key = "specific", value = "action" },
				pattern = "revslider_show_image",
				operator = "EQUALS"
			},
			opts = { nolog = true },
			action = "CHAIN"
		},
		{
			id = 90018,
			var = {
				type = "URI_ARGS",
				opts = { key = "specific", value = "img" },
				pattern = [=[^\.\./wp-*|\.php$]=],
				operator = "REGEX"
			},
			action = "DENY",
			description = "Slider Revolution WordPress Plugin LFI Vulnerability"
		},
		{
			id = 90019,
			var = {
				type = "REQUEST_ARGS",
				opts = { key = "all" },
				pattern = [=[^\(\)]=],
				operator = "REGEX"
			},
			action = "DENY",
			description = "Bash environmental variable injection (CVE-2014-6271)",
		},
		{
			id = 90020,
			var = {
				type = "REQUEST_HEADERS",
				opts = { key = "all" },
				pattern = [=[^\(\)]=],
				operator = "REGEX"
			},
			action = "DENY",
			description = "Bash environmental variable injection (CVE-2014-6271)"
		},
		{
			id = 90021,
			var = {
				type = "URI",
				pattern = "/wp-login.php",
				operator = "EQUALS"
			},
			opts = { nolog = true },
			action = "CHAIN"
		},
		{
			id = 90022,
			var = {
				type = "METHOD",
				pattern = "POST",
				operator = "EQUALS"
			},
			opts = { nolog = true },
			action = "CHAIN"
		},
		{
			id = 90023,
			var = {
				type = "USER_AGENT",
				pattern =  "Mozilla/5.0 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)",
				operator = "EQUALS"
			},
			action = "DENY",
			description = "Emerging fake Googlebot wp-login bruteforce"
		},
		{
			id = 90024,
			var = {
				type = "REQUEST_BODY",
				opts = { key = 'keys' },
				pattern = "mfbfw",
				operator = "CONTAINS"
			},
			opts = { nolog = true, transform = 'lowercase' },
			action = "CHAIN",
		},
		{
			id = 90025,
			var = {
				type = "REQUEST_BODY",
				opts = { key = 'specific', value = 'action' },
				pattern = 'update',
				operator = "EQUALS"
			},
			opts = { nolog = true, transform = 'lowercase' },
			action = "CHAIN"
		},
		{
			id = 90026,
			var = {
				type = "URI_ARGS",
				opts = { key = 'specific', value = 'page' },
				pattern = 'fancybox-for-wordpress',
				operator = "EQUALS"
			},
			opts = { nolog = true, transform = 'lowercase' },
			action = "CHAIN"
		},
		{
			id = 90027,
			var = {
				type = "URI",
				pattern = '/wp-admin/admin-post.php',
				operator = "EQUALS"
			},
			opts = { nolog = true, transform = 'lowercase' },
			action = "CHAIN"
		},
		{
			id = 90028,
			var = {
				type = "METHOD",
				pattern = "POST",
				operator = "EQUALS"
			},
			action = "DENY",
			description = "FancyBox for Wordpress access control vulnerability (https://www.cryptobells.com/fancybox-for-wordpress-zero-day-and-broken-patch/)"
		}
	}
}

return _M
