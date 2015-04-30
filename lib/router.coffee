Router.configure 
	layoutTemplate: 'layout',
	loadingTemplate: 'loading',
	waitOn: ->
		return [Meteor.subscribe('posts'), Meteor.subscribe('notifications')]

Router.map () ->
	@.route '/', name: 'postsList'
	@.route '/posts/:_id', 
		name: 'postPage',
		waitOn: ->
			return Meteor.subscribe 'comments', @params._id
		data: () ->
			return Posts.findOne @params._id
	@.route '/submit',
		name: 'postSubmit'
	@.route '/posts/:_id/edit',
		name: 'postEdit',
		data: ->
			return Posts.findOne @.params._id

requireLogin = ->
	return @render 'accessDenied' if !Meteor.user()
	return @next()

Router.onBeforeAction requireLogin, only: 'postSubmit'
Router.onBeforeAction ->
	clearErrors()
	@next()