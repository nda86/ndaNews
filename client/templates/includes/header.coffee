Template.header.helpers
	activeRouteClass: ->
		args = Array::slice.call(arguments,0)
		args.pop()
		active = _.any args, (name) ->
			return Router.current() and Router.current().route.getName() is name
		return active and 'active'