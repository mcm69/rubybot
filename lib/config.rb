module Rubybot
	module Config
		#bot creator. always has access to all commands
		BOT_CREATOR = 'echo123'

		#bot admins. have access to commands that use is_admin? but not is_creator?
		BOT_ADMINS = []

		#timeout (in minutes) for incoming messages. used to ignore old logs slipping through
		MESSAGE_TIMEOUT = 2

		def Config.is_creator? (user)
			user == BOT_CREATOR
		end

		def Config.is_admin? (user)
			is_creator?(user) || BOT_ADMINS.include?(user)
		end
	end
end