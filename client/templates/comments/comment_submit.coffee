Template.commentSubmit.events =
	'submit form': (e, template) ->
		e.preventDefault()
		$body = $(e.target).find('[name=body]')
		comment =
			body: $body.val(),
			postId: template.data._id
		Meteor.call 'comment', comment, (err, commentId) ->
			return throwError err.reason if err
			return $body.val('')