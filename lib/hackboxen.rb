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

require 'hackboxen/utils/load_config'
