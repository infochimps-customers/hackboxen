require 'pathname'

module HackBoxen

  module Paths

    def paths
      @paths ||= default_paths
    end

    def path_to *pathsegs
      path = Pathname.new path_to_helper(*pathsegs)
      path.absolute? ? File.expand_path(path) : path.to_s
    end

    def default_paths
      {
        # root directories
        :home        => ENV['HOME'],
        :data_root   => HackBoxen.dataroot,
        :code_root   => HackBoxen.coderoot,
        # local hackbox directories
        :hb_current  => [:code_root, HackBoxen.current, HackBoxen.name],
        :hb_engine   => [:hb_current, 'engine'],
        :hb_config   => [:hb_current, 'config'],
        # output directories
        :hb_dataroot => [:data_root, HackBoxen.current],
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
    def path_to_helper *pathsegs
      expanded = pathsegs.flatten.compact.map do |pathseg|
        case
        when pathseg.is_a?(Symbol) && paths.include?(pathseg) then path_to(paths[pathseg])
        when pathseg.is_a?(Symbol)                            then raise "No path expansion set for #{pathseg.inspect}"
        else pathseg
        end
      end
      File.join(*expanded)
    end

  end

end
