pluginlist = Pluginfactory.create('pluginlist', 'returns list of currently loaded plugins', 'plugin list') do |message|
	response = ""
	Rubybot.plugins.each {|p| response += "#{p.class::COMMAND}: #{p.about}\r\n"}

	Rubybot.skype.send_chat_message(message.convo_id, response)
end

Rubybot.register_plugin pluginlist