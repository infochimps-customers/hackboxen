INCLUDING_FILE = caller[2].gsub(/:.*$/, '') unless defined?(INCLUDING_FILE)

require 'rake'
require 'swineherd'
require 'configliere'
require 'json'

require 'hackboxen/utils/load_config'

require 'hackboxen/tasks/init'
require 'hackboxen/tasks/icss'

include HackBoxen::Paths

::HackBoxen.extend Rake::DSL
