def require_all(path)
	project_root = File.dirname(File.absolute_path(__FILE__))
	Dir.glob(project_root + '/' + path) {|file| require file}
end