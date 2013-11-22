rc = Pluginfactory.create('rc', 'echoes a message/command into the current chat', 'remote control') do |message|
	args = message.body.args
	return unless Rubybot::Config.is_admin? message.author
	Rubybot.skype.send_chat_message(message.convo_id, args)
end

Rubybot.register_plugin rc