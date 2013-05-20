require "./helpers.rb"
require 'skypekit'

module Rubybot
  class << self; attr_accessor :plugins; end

  COMMAND_SYMBOL = '-'

  self.plugins = []

  #init plugins

  def Rubybot.register_plugin(plugin)
    if !(plugin.respond_to?(:handle) && plugin.respond_to?(:about) && plugin.respond_to?(:helptext))
      raise NoMethodError
    end
    self.plugins.push plugin
  end

  require_all "plugins/*.rb"


  def handle_message(message)
    self.plugins.each do |plugin|
          next if !plugin.respond_to? :handle
          plugin.handle message
    end
  end

  def terminate
      puts "Terminating"
      $skype.stop
      exit
  end

  def Rubybot.start
    #get username and password
    login, pass = IO.readlines('login.dat')

    self.plugins.each do |p|
      puts "#{p.class::COMMAND}: #{p.about}"
    end

    trap('INT') do
      terminate
    end

    #create the bot
    puts "creating Skype and connecting"
    $skype = Skypekit::Skype.new(:keyfile => 'myskypekit.pem')

    $skype.start
    $skype.login(login, pass)
    puts "done creating"
    

   

    #main loop
    loop do
      event = $skype.get_event

      unless event
        sleep 2
        next
      end

      case event.type
      when :account_status

        if event.data.logged_in?
          puts "Congrats! We are Logged in!"
        end

        if event.data.logged_out?
          puts "Authentication failed: #{event.data.reason}"
          terminate
        end

      when :chat_message
        message = event.data

        puts "@" * 80
        p message
        puts "@" * 80

        handle_message message

      end
    end
  end
end

Rubybot.start