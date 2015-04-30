Router.configure 
	layoutTemplate: 'layout',
	loadingTemplate: 'loading',
	waitOn: ->
		return [Meteor.subscribe('notifications')]

PostsListController = RouteController.extend
	template: 'postsList',
	increment: 5,
	limit: ->
		return parseInt(@params.postsLimit) or @increment
	findOptions: ->
		return {sort: {submitted: -1}, limit: @limit()}
	onBeforeAction: ->
		@postsSub = Meteor.subscribe('posts', @findOptions())
		return @next()
	posts: ->
		return Posts.find({}, @findOptions())
	nextPath: ->
		return @route.path(postsLimit: @limit() + @increment)
	data: ->
		hasMore = @posts().fetch().length is @limit()
		return {
			posts: @posts(),
			# ready: this.postsSub.ready(),
			nextPath: if hasMore then @nextPath() else null
		}

Router.map () ->
	@.route '/posts/:_id', 
		name: 'postPage',
		waitOn: ->
			return [
				Meteor.subscribe('singlePost', @params._id),
				Meteor.subscribe('comments', @params._id)
			]
		data: ->
			return Posts.findOne @params._id

	@.route '/submit',
		name: 'postSubmit',
		progress: off

	@.route '/posts/:_id/edit',
		name: 'postEdit',
		waitOn: ->
			return [
				Meteor.subscribe('singlePost', @params._id)
			]
		data: ->
			return Posts.findOne @params._id

	@.route '/:postsLimit?',
		name: 'postsList',
		controller: PostsListController

requireLogin = ->
	return @render 'accessDenied' if !Meteor.user()
	return @next()

Router.onBeforeAction requireLogin, only: 'postSubmit'
Router.onBeforeAction ->
	clearErrors()
	@next()