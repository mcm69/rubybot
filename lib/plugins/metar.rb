require 'metar'

metar = Pluginfactory.create('metar', 'current weather for an airport given an ICAO code', 'aviation weather report') do |message|
	args = message.args
	response = ''
	if(!args)
		response = 'metar: No airport code provided'
	else
		icao = args.upcase
		station = Metar::Station.find_by_cccc(icao);
		if(!station)
			response = "metar: Invalid airport code #{icao}!"
		else
			report = station.report.to_s
			raw = station.parser.raw.to_s
			response = "METAR #{raw}\n\nreport"
		end
	end

	Rubybot.skype.send_chat_message(message.convo_id, response)
end

Rubybot.register_plugin metar