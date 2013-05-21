class Uptime
	COMMAND = Rubybot::COMMAND_SYMBOL + 'uptime'

	def initialize
		@start = Time.now
	end

	def handle(message)
		return unless message.body.is_command(COMMAND)

		elapsed = Time.now - @start
		seconds = elapsed%60
		minutes = elapsed/60%60
		hours = elapsed/3600%24
		days = elapsed/3600.to_i

		Rubybot.skype.send_chat_message(message.convo_id, "robot uptime: #{days}d #{hours}h #{minutes}m #{seconds}s, running since #{@start}")	
	end

	def command
		COMMAND
	end

	def about
		'Robot uptime'
	end

	def helptext
		'Returns the time interval the robot has been up for.'
	end
end