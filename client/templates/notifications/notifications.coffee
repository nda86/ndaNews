Template.notifications.helpers
	notifications: ->
		return Notifications.find(userId: Meteor.userId(), read: off)
	notificationCount: ->
		return Notifications.find(userId: Meteor.userId(), read: off).count()


Template.notification.helpers
	notificationPostPath: ->
		return Router.routes.postPage.path(_id: @postId)

Template.notification.events
	'click a': ->
		Notifications.update(@_id, {$set: {read: on}})
