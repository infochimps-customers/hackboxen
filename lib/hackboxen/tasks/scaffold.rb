require 'rubygems'
require 'configliere'
require 'rake'

hb_lib_dir     = File.join(File.dirname(__FILE__), '../../../')
machine_config = '/etc/hackbox/hackbox.yaml'
install_config = File.join(ENV['HOME'], '.hackbox/hackbox.yaml')

Settings.use :commandline, :config_file
Settings.define :namespace, :required => true
Settings.define :protocol,  :required => true
Settings.define :coderoot,  :required => true
Settings.define :targets,   :default  => 'catalog'
Settings.read(machine_config) if File.exists? machine_config
Settings.read(install_config) if File.exists? install_config
Settings.resolve!

# Hackbox directories to be created
coderoot = Settings[:coderoot]
hackbox  = File.join(coderoot, Settings[:namespace].gsub(/\./,'/'), Settings[:protocol])
engine   = File.join(hackbox, 'engine')
config   = File.join(hackbox, 'config')

# Define idempotent directory tasks
[ coderoot, hackbox, engine, config ].each { |dir| directory dir }

# Hackbox files to be created
rakefile    = File.join(hackbox, 'Rakefile')
main        = File.join(engine, 'main')
config_yml  = File.join(config, 'config.yaml')
icss_yml    = File.join(config, "#{Settings[:protocol]}.icss.yaml")
endpoint    = File.join(engine, "#{Settings[:protocol]}_endpoint.rb")
templates   = File.join(hb_lib_dir, 'lib/hackboxen/template')

# Create a basic endpoint if apeyeye was specified as a target
file endpoint, [:config] => engine do |t, args|
  HackBoxen::Template.new(File.join(templates, "endpoint.rb.erb"), endpoint, args[:config]).substitute!
end

# Create a basic hackbox Rakefile
file rakefile => hackbox do
  HackBoxen::Template.new(File.join(templates, "Rakefile.erb"), rakefile, {}).substitute!
end

# Create a basic executable hackbox main file
file main => engine do
  HackBoxen::Template.new(File.join(templates, 'main.erb'), main, {}).substitute!
  File.chmod(0755, main)
end

# Create a basic config file
file config_yml => config do
  basic_config = { 'namespace' => Settings[:namespace], 'protocol'  => Settings[:protocol] }
  HackBoxen::Template.new(File.join(templates, "config.yaml.erb"), config_yml, basic_config).substitute!
end

# Create a basic icss file
file icss_yml => config do
  targets = Settings[:targets].split(',')
  basic_config = {
    'namespace' => Settings[:namespace],
    'protocol'  => Settings[:protocol],
    'targets'   => targets
  }
  HackBoxen::Template.new(File.join(templates, "icss.yaml.erb"), icss_yml, basic_config).substitute!
  Rake::Task[endpoint].invoke(basic_config) if targets.include? 'apeyeye'
end

task :scaffold => [rakefile, main, config_yml, icss_yml]


