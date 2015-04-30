Template.postPage.helpers
	comments: ->
		return Comments.find postId: @_id