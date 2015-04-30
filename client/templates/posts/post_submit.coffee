Template.postSubmit.events 
	'submit form': (e) ->
		e.preventDefault()
		post =
			url: $(e.target).find('[name=url]').val()
			title: $(e.target).find('[name=title]').val()

		

		Meteor.call 'postInsert',post, (err, result) ->
			return throwError err.reason if err
			throwError 'This link is already posted!' if result.postExists
			return Router.go 'postPage', _id: result._id
