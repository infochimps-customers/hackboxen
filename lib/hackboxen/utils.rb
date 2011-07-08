WorkingConfig  = Configliere::Param.new
WorkingConfig.use :commandline, :config_file

module HackBoxen

  autoload :ConfigValidator, 'hackboxen/utils/config_validator'
  autoload :Paths,           'hackboxen/utils/paths'
  autoload :Logging,         'hackboxen/utils/logging'

  def self.find_root_dir
    start_dir = File.dirname INCLUDING_FILE
    Dir.chdir start_dir
    until hackbox_root? Dir.pwd
      Dir.chdir('..')
      if Dir.pwd == '/'
        puts "Warning: not in a Hackbox base directory"
        return start_dir
      end
    end
    return Dir.pwd
  end

  def self.hackbox_root? dir = Dir.pwd
    %w[ engine config Rakefile ].each do |expected|
      return false unless Dir.entries(dir).include? expected
    end
    true
  end

  def self.current_fs
    fs = WorkingConfig[:filesystem_scheme] ? WorkingConfig[:filesystem_scheme] : 'file'
    Swineherd::FileSystem.get fs
  end

  def self.name
    hackbox_root? ? Dir.pwd.gsub(/#{WorkingConfig[:coderoot]}\/#{current}\//, '') : 'debug'
  end

  def self.current
    hackbox_root? ? WorkingConfig[:namespace].gsub('.', '/') : Dir.pwd
  end

  def self.coderoot
    WorkingConfig[:coderoot]
  end

  def self.dataroot
    WorkingConfig[:dataroot]
  end


  def self.verify_dependencies
    %w[ coderoot dataroot namespace ].each do |req|
      raise "Your hackbox config appears to be missing a [#{req}]" unless WorkingConfig[req.to_sym]
    end
  end

  def self.read_config cfg
    WorkingConfig.read cfg if current_fs.exists?(cfg)
  end
end

