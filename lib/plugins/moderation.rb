class Moderation
	KICK_COMMAND = Rubybot::COMMAND_SYMBOL + 'kick'
	KICKBAN_COMMAND = Rubybot::COMMAND_SYMBOL + 'kickban'
	PROMOTE_COMMAND = Rubybot::COMMAND_SYMBOL + 'promote'
	DEMOTE_COMMAND = Rubybot::COMMAND_SYMBOL + 'demote'
	SILENCE_COMMAND = Rubybot::COMMAND_SYMBOL + 'silence'
	ADD_COMMAND = Rubybot::COMMAND_SYMBOL + 'add'

	COMMANDS = [KICK_COMMAND, KICKBAN_COMMAND, PROMOTE_COMMAND, DEMOTE_COMMAND, SILENCE_COMMAND, ADD_COMMAND]

	def handle(message)
		return unless message.body.is_command? COMMANDS

		if !Rubybot::Config.is_admin? message.author
			Rubybot.skype.send_chat_message(message.convo_id, "You do not have permissions to use this command, #{message.author_displayname}!")
			return
		end

		victim = message.body.args.strip
		response = ""
		case message.body.command
		when KICK_COMMAND
			response = "/kick #{victim}"
		when KICKBAN_COMMAND
			response = "/kickban #{victim}"
		when PROMOTE_COMMAND
			response = "/setrole #{victim} master"
		when DEMOTE_COMMAND
			response = "/setrole #{victim} user"
		when SILENCE_COMMAND
			response = "/setrole #{victim} listener"
		when ADD_COMMAND
			response = "/add #{victim}"
		end

		Rubybot.skype.send_chat_message(message.convo_id, response)
	end

	def command
		"moderation"
	end

	def about
		'Moderation tools'
	end

	def helptext
		'Kick/ban, promote, demote, silence and add users.'
	end
end

Rubybot.register_plugin Moderation.new