Template.comment.helpers
	submittedText: ->
		local = 'en-US'
		options =
			year: 'numeric',
			month: 'long',
			day: 'numeric',
			weekday: 'long',
			hour: 'numeric',
			minute: 'numeric',
			second: 'numeric'
		return new Date(@submitted).toLocaleString(local,options)