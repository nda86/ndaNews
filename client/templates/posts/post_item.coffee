Template.postItem.helpers
	domain: ->
		a = document.createElement 'a'
		a.href = @.url
		return a.hostname
	isOwn: ->
		return @.userId is Meteor.userId()