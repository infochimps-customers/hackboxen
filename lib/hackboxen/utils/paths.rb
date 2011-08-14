require 'pathname'

module HackBoxen
  module Paths
    module_function

    def paths
      @paths ||= default_paths
    end

    def path_to *pathsegs
      path = Pathname.new HackBoxen::Paths.path_to_helper(*pathsegs)
      path.absolute? ? File.expand_path(path) : path.to_s
    end

    def default_paths
      {
        # root directories
        :home        => ENV['HOME'],
        :data_root   => :get_data_root,
        :code_root   => :get_code_root,
        # local hackbox directories
        :hb_current  => [:code_root, :get_hb_current, :hb_name],
        :hb_engine   => [:hb_current, 'engine'],
        :hb_config   => [:hb_current, 'config'],
        # output directories
        :hb_dataroot => [:data_root, :get_hb_current],
        :ripd_dir    => [:hb_dataroot, 'ripd'],
        :rawd_dir    => [:hb_dataroot, 'rawd'],
        :fixd_dir    => [:hb_dataroot, 'fixd'],
        :pkgd_dir    => [:hb_dataroot, 'pkgd'],
        :log_dir     => [:hb_dataroot, 'log'],
        :env_dir     => [:hb_dataroot, 'env'],
        :data_dir    => [:fixd_dir, 'data'],
        :code_dir    => [:fixd_dir, 'code']
      }
    end

    private
    def self.path_to_helper *pathsegs
      expanded = pathsegs.flatten.compact.map do |pathseg|
        case
        when pathseg.is_a?(Symbol) && paths.include?(pathseg) then path_to(paths[pathseg])
        when pathseg == :get_hb_current then HackBoxen.current
        when pathseg == :hb_name        then HackBoxen.name
        when pathseg == :get_data_root  then HackBoxen.dataroot
        when pathseg == :get_code_root  then HackBoxen.coderoot
        when pathseg.is_a?(Symbol)      then raise "No path expansion set for #{pathseg.inspect}"
        else pathseg
        end
      end
      File.join(*expanded)
    end

  end
end
