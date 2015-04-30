Meteor.publish 'posts', (options) ->
	return Posts.find({}, options)

Meteor.publish 'comments', (pId) ->
	return Comments.find({postId: pId})

Meteor.publish 'notifications',->
	return Notifications.find(userId: @id)


Meteor.publish 'singlePost',(pId) ->
	return Posts.find({_id: pId})