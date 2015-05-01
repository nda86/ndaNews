@Posts = new Meteor.Collection 'posts'
Posts.allow
	update: ownsDocument,
	remove: ownsDocument

Posts.deny
	update: (userId, post, fieldNames) ->
		return (_.without(fieldNames, 'url', 'title').length > 0)

@validatePost = (post) ->
			errors = status: 'invalid'
			errors.url = 'Please fill in a url' if !post.url
			errors.title = 'Please fill in a title' if !post.title
			return errors

@samePost = (post) ->
	same = Posts.findOne url: post.url
	return postExists: on, _id: same._id, url: same.url if same

Meteor.methods
	postInsert: (postAttributes) ->

		# check Meteor.userId(), String
		# check postAttributes,
		# 	url: String,
		# 	title: String

		errors = validatePost(postAttributes)
		throw new Meteor.Error errors.status, errors.title if errors.title
		throw new Meteor.Error errors.status, errors.url if errors.url

		same = samePost(postAttributes)
		return same if same

		user = Meteor.user()
		post = _.extend(_.pick(postAttributes, 'url', 'title', 'message'),
			userId: user._id,
			author: user.username,
			submitted: new Date().getTime(),
			commentsCount: 0,
			upvoters = [],
			votes: 0
		)
		postId = Posts.insert post
		return _id: postId
	upvote: (postId) ->
		user = Meteor.user()
		throw new Meteor.Error 401, 'You need to be logged to vote' if !user
		# post = Posts.findOne postId
		# throw new Meteor.Error 422, 'Post not found' if !post
		# throw new Meteor.Error 422, 'You already vote for this post' if _.include(post.upvoters, user._id)
		Posts.update({_id: postId, upvoters: {$ne: user._id}}, {$addToSet: {upvoters: user._id}, $inc: {votes: 1}})

