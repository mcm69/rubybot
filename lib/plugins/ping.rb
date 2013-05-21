ping = Pluginfactory.create('ping', 'returns pong when requested a ping', 'simple ping') do |message|
	Rubybot.skype.send_chat_message(message.convo_id, "pong")
end
Rubybot.register_plugin ping