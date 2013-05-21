require "./helpers.rb"
require "./pluginfactory.rb"
require 'skypekit'

module Rubybot
  class << self; attr_accessor :plugins; end
  class << self; attr_accessor :skype; end

  COMMAND_SYMBOL = '-'

  self.plugins = []

  #init plugins

  def Rubybot.register_plugin(plugin)
    self.plugins.push plugin
  end

  require_all "plugins/*.rb"


  def Rubybot.handle_message(message)
    self.plugins.each do |plugin|
          plugin.handle message
    end
  end

  def Rubybot.terminate
      puts "Terminating"
      @skype.stop
      exit
  end

  def Rubybot.start
    #get username and password
    login, pass = IO.read("login.dat").split($/)

    self.plugins.each do |p|
      puts "#{p.command}: #{p.about}"
    end

    #create the bot
    puts "creating Skype and connecting user #{login}"
    @skype = Skypekit::Skype.new(:keyfile => 'myskypekit.pem')

    @skype.start
    @skype.login(login, pass)
    
    #main loop
    loop do
      event = @skype.get_event

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
        #ignore messages we sent ourselves
        message = event.data
        next if message.author == login

        puts "@" * 80
        p message
        puts "@" * 80

        self.handle_message message

      end
    end
  end
end

trap('INT') do
      Rubybot.terminate
end


Rubybot.start