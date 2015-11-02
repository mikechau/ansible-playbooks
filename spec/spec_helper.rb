require 'serverspec'
require 'net/ssh'
require 'tempfile'

Dir["./spec/support/**/*.rb"].sort.each { |f| require f }

options = {}

if ENV['SERVER_SPEC_LOCAL']
  set :backend, :exec

elsif ENV['TRAVIS']
  options = {
    user: 'root',
    port: 9001,
    keys: [
      File.expand_path('../.insecure_keys/test_key.rsa', __dir__)
    ],
    paranoid: false,
    user_known_hosts_file: '/dev/null',
    keys_only: true
  }

  set :backend, :ssh
  set :host, 'localhost'
  set :ssh_options, options
else
  set :backend, :ssh

  # if ENV['ASK_SUDO_PASSWORD']
  #   begin
  #     require 'highline/import'
  #   rescue LoadError
  #     fail "highline is not available. Try installing it."
  #   end
  #   set :sudo_password, ask("Enter sudo password: ") { |q| q.echo = false }
  # else
  #   set :sudo_password, ENV['SUDO_PASSWORD']
  # end

  host = ENV['TARGET_HOST']

  `vagrant up #{host}`

  config = Tempfile.new('', Dir.tmpdir)
  config.write(`vagrant ssh-config #{host}`)
  config.close

  options = Net::SSH::Config.for(host, [config.path])

  options[:user] ||= Etc.getlogin

  set :host,        options[:host_name] || host
  set :ssh_options, options

  # Disable sudo
  # set :disable_sudo, true

  # Set environment variables
  # set :env, :LANG => 'C', :LC_MESSAGES => 'C'

  # Set PATH
  # set :path, '/sbin:/usr/local/sbin:$PATH'
end

RSpec.configure do |c|
  c.before do
    @ssh_user = options[:user]
  end
end