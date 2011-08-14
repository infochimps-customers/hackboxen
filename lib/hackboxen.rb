INCLUDING_FILE = caller[2].gsub(/:.*$/, '') unless defined?(INCLUDING_FILE)

require 'rake'
require 'swineherd'
require 'configliere'
require 'json'

# # require 'hackboxen/utils' causes the following:
#
# WorkingConfig  = Configliere::Param.new
# WorkingConfig.use :commandline, :config_file
#
# module Hackboxen
#   autoload :ConfigValidator, 'hackboxen/utils/config_validator'
#   autoload :Paths,           'hackboxen/utils/paths'
#   # require 'pathname'
#   autoload :Logging,         'hackboxen/utils/logging'
#   # require 'log4r'
# end
#
# require 'pathname' # from utils/paths, force-invoked below
#
require 'hackboxen/utils'

# # require 'hackboxen/tasks' causes the following:
#
# require 'hackboxen/tasks/init'
# include Rake::DSL
# require 'hackboxen/tasks/icss'
# require 'hackboxen/tasks/mini'
# # require 'swineherd'
# # require 'configliere'
# require 'hackboxen/tasks/endpoint'
#
# include HackBoxen::Paths
#
::HackBoxen.extend Rake::DSL
require 'hackboxen/tasks'

machine_cfg = "/etc/hackbox/hackbox.yaml"
user_cfg    = File.join(ENV['HOME'], '.hackbox/hackbox.yaml')
hackbox_cfg = File.join(HackBoxen.find_root_dir, 'config/config.yaml')

WorkingConfig.read machine_cfg if File.exists? machine_cfg
WorkingConfig.read user_cfg    if File.exists? user_cfg
WorkingConfig.read hackbox_cfg if File.exists? hackbox_cfg

