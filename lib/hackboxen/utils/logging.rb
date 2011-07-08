require 'log4r'

module HackBoxen
  module Logging
    include Log4r
    include Paths

    def logs_to *args
      @log = Logger.new('hackbox_logger')
      @log.outputters = args.map do |location|
        l = create_log(location)
        l.formatter = default_format
        l
      end
      def log
        @log
      end
    end

    private

    def default_format
      PatternFormatter.new(:pattern =>"[%l] %d :: %m")
    end

    def default_file
      { :filename => File.join(path_to(:log_dir), 'hb-log'), :trunc => false }
    end

    def create_log location
      case location
      when STDOUT then Outputter.stdout
      when STDERR then Outputter.stderr
      when 'file' then FileOutputter.new('hb_log_file', default_file)
      end
    end

  end
end
