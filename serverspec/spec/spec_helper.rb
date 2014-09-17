require 'serverspec'
require 'pathname'
require 'net/ssh'
require 'yaml'

Dir["./shared/**/*.rb"].sort.each{ |f| require f }

include Serverspec::Helper::Ssh
include Serverspec::Helper::DetectOS
include Serverspec::Helper::Properties

properties = YAML.load_file('properties.yml')

RSpec.configure do |c|
  c.request_pty = true

  if ENV['ASK_SUDO_PASSWORD']
    require 'highline/import'
    c.sudo_password = ask("Enter sudo password: ") { |q| q.echo = false }
  else
    c.sudo_password = ENV['SUDO_PASSWORD']
  end

  c.before :all do
    block = self.class.metadata[:block]

    if RUBY_VERSION.start_with?('1.8')
      file = block.to_s.match(/.*@(.*):[0-9]+>/)[1]
    else
      file = block.source_location.first
    end

    base = File.basename(Pathname.new(file))
    host = /(.*)_spec.rb/.match(base)[1]

    if c.host != host
      c.ssh.close if c.ssh
      c.host  = host
      options = Net::SSH::Config.for(c.host)
      user    = options[:user] || Etc.getlogin
      c.ssh   = Net::SSH.start(host, user, options)
    end

    set_property properties[c.host]

  end
end
