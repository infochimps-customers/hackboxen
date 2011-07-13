INCLUDING_FILE = caller[2].gsub(/:.*$/, '') unless defined?(INCLUDING_FILE)

require 'rake'
require 'swineherd'
require 'configliere'
require 'json'
require 'hackboxen/utils'
require 'hackboxen/tasks'

machine_cfg = "/etc/hackbox/hackbox.yaml"
user_cfg    = File.join(ENV['HOME'], '.hackbox/hackbox.yaml')
hackbox_cfg = File.join(HackBoxen.find_root_dir, 'config/config.yaml')

WorkingConfig.read machine_cfg if File.exists? machine_cfg
WorkingConfig.read user_cfg    if File.exists? user_cfg
WorkingConfig.read hackbox_cfg if File.exists? hackbox_cfg

