module Pluginfactory
	def self.create(command, helptextmsg, aboutmsg, &handlerblock)
		# here we define a class which defines three methods.
		# handlerblock parameter is the method body which will handle the message if the command passed
		# equals to the command parameter supplied
		# helptext and about are just strings which will be the return values of same-named methods of the defined class
		cls = Class.new(Object) do 
			define_method(:handler) do |message|
				return unless message[0,command.length+1] == Rubybot::COMMAND_SYMBOL + command
				handlerblock.call message
			end

			define_method(:helptext) { helptextmsg }

			define_method(:about) { aboutmsg }
		end

		cls.const_set("COMMAND", command)

		cls.new
	end
end