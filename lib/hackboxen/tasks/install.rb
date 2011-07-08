require 'rubygems'
require 'rake'
require 'configliere'
require 'ohai'

Settings.use :commandline
Settings.define :dataroot, :default => "/data/hb",          :description => "Global directory for hackbox output"
Settings.define :coderoot, :default => "#{ENV['HOME']}/hb", :description => "Global directory for hackbox code"
Settings.resolve!

config_dir = File.join(ENV["HOME"], '.hackbox')
config     = File.join(config_dir, 'hackbox.yaml')

directory config_dir

file config => [config_dir] do

  # Create config hash and setup defaults
  config_hash = {}
  config_hash['dataroot'] = Settings[:dataroot]
  config_hash['coderoot'] = Settings[:coderoot]

  # Configure S3 setup if desired
  s3_setup = { 'access_key'  => '', 'secret_key'  => '' }
  print "Configure S3 Filesystem information? [Y]n "
  unless STDIN.gets.downcase.chomp == 'n'
    print "Access Key: "
    s3_setup['access_key']  = STDIN.gets.chomp
    print "Secret Key: "
    s3_setup['secret_key']  = STDIN.gets.chomp
  end
  config_hash['s3_filesystem'] = s3_setup

  # Add system requirements
  sys = Ohai::System.new
  sys.all_plugins
  config_hash['requires'] = {
    'machine' => sys[:kernel][:machine],
    'os'      => sys[:os]
  }

  File.open(config, 'wb') { |f| f.puts config_hash.to_yaml }
end

desc "Create the install-level config file, ~/.hackbox/hackbox.yaml"
task :install => [config]
