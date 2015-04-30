Meteor.publish 'posts', ->
	return Posts.find()

Meteor.publish 'comments', (pId) ->
	return Comments.find({postId: pId})

Meteor.publish 'notifications',->
	return Notifications.find(userId: @id)