POST_HEIGHT = 80
Positions = new Meteor.Collection null

Template.postItem.helpers
	domain: ->
		a = document.createElement 'a'
		a.href = @.url
		return a.hostname
	isOwn: ->
		return @.userId is Meteor.userId()
	upvotedClass: ->
		userId = Meteor.userId()
		if userId and !_.include(@upvoters, userId)
			return 'btn-info upvotable'
		else
			return 'disabled'
	# attributes: ->
	# 	post = _.extend({}, Positions.findOne({postId: @_id}),@)
	# 	newPosition = post._rank * POST_HEIGHT
	# 	attributes = {}
	# 	if !_.isUndefined(post.position)
	# 		offset = post.position - newPosition
	# 		attributes.style = "top: " + offset + "px"
	# 		if offset is 0 then attributes.class = 'post animate'
	# 	Meteor.setTimeout ->
	# 		Position.upsert({postId: post._id}, {$set: {position: newPosition}})
	# 	return attributes

Template.postItem.events
	'click a.upvotable': (e) ->
		e.preventDefault()
		Meteor.call 'upvote', @_id, (err) ->
			throwError err.reason if err