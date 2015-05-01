UI.registerHelper 'pluralize', (n, thing) ->
	return '0 ' + thing + 's' if !n
	return '1 ' + thing if n is 1
	return n + ' ' + thing + 's'
