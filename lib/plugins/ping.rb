class Ping
	COMMAND = Rubybot::COMMAND_SYMBOL + 'ping'

	def handle(message)
		return unless message.body[0,5] == COMMAND

		$skype.send_chat_message(message.convo_id, "pong")
	end

	def helptext
		"returns pong when requested a ping";
	end

	def about
		"ping plugin 1.0"
	end
end

Rubybot.register_plugin Ping.new