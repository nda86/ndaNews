Template.postEdit.events
	'submit form': (e) ->
		e.preventDefault()

		url = $(e.target).find('[name=url]').val()
		title = $(e.target).find('[name=title]').val()
		originUrl = $(e.target).find('[name=originUrl]').val()
		post = {}
		post['url'] = url if url
		post['title'] = title if title
		return Router.go 'postsList' if !url and !title

		same = samePost(post)
		if same and same.url isnt originUrl
			throwError 'This link is already posted!'
			return Router.go 'postPage', _id: same._id

		currentPostId = @_id
		Posts.update currentPostId, $set: post, (err) ->
			return console.log err.reason if err
			return Router.go 'postPage', _id: currentPostId

	'click .delete': (e) ->
		e.preventDefault()
		if confirm 'Really delete this awesome post???'
			currentPostId = @_id
			Posts.remove currentPostId
			Router.go 'postsList'