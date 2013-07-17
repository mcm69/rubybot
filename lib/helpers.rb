def require_all(path)
	project_root = File.dirname(File.absolute_path(__FILE__))
	Dir.glob(project_root + '/' + path) {|file| require file}
end

class String
	def is_command?(command)
		commands = [*command]
		commands.each do |cmd|
			return true if self == cmd || (self.start_with? cmd + ' ')
		end
		false
	end

	def args
		self.split(' ', 2)[1]
	end
end