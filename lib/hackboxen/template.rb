require 'erubis'

module HackBoxen
  class Template

    attr_accessor :source_template, :output_path, :attributes

    def initialize source_template, output_path, attributes
      @source_template = source_template
      @output_path     = output_path
      @attributes      = attributes
    end

    def compile!
      dest << Erubis::Eruby.new(source).result(attributes)
      dest << "\n"
      dest
    end

    def substitute!
      compile!
    end

    protected

    def source
      File.open(source_template).read
    end

    def dest
      return @dest if @dest
      @dest ||= File.open(output_path, 'w')
    end

  end
end
