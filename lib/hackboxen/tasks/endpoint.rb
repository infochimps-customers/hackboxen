module HackBoxen
  namespace :hb do

    desc "Copy an endpoint.rb file to the output code directory if the endpoint exists"
    task :endpoint => ['hb:create_required_paths'] do
      endpoint = "#{WorkingConfig[:protocol]}_endpoint.rb"
      srcfile  = File.join(path_to(:hb_engine), endpoint)
      if File.exists? srcfile
        HackBoxen.current_fs.mkpath path_to(:code_dir)
        destfile = File.join(path_to(:code_dir), endpoint)
        HackBoxen.current_fs.cp(srcfile, destfile)
      end
    end

  end
end
