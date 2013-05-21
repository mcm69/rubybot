pluginlist = Pluginfactory.create('help', 'returns list of currently loaded plugins or help for a particular command', 'help') do |message|
	response = ""
	args = message.body.args
	if(args)
		#display help text for a particular command
		cmd = Rubybot::COMMAND_SYMBOL+args
		plugin = Rubybot.plugins.find {plugin.class::COMMAND == cmd}
		if plugin
			response = "#{cmd}: #{plugin.helptext}"
		else
			response = "No such command: #{cmd}"
		end
	else
		#display the command list
		Rubybot.plugins.each {|p| response += "#{p.class::COMMAND}: #{p.about}\n"}
		response += "\nFor help on particular command type #{Rubybot::COMMAND_SYMBOL}help command"
	end

	Rubybot.skype.send_chat_message(message.convo_id, response)	
end

Rubybot.register_plugin pluginlist