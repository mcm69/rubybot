require "./helpers.rb";

$plugins = [];

require_all "plugins/*.rb";

#$plugins.each {|plugin| puts plugin}

login, pass = IO.readlines('login.dat');

puts login, pass
