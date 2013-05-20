class Pluginlist
	COMMAND = Rubybot::COMMAND_SYMBOL + 'help';

	def handle(message)
		return unless message.body[0,5] == COMMAND

		response = ""
		Rubybot.plugins.each {|p| response += "#{p.class::COMMAND}: #{p.about}\r\n"}

		$skype.send_chat_message(message.convo_id, response)
	end

	def helptext
		"returns command list or help text for a particular command";
	end

	def about
		"command list"
	end
end

Rubybot.register_plugin Pluginlist.new