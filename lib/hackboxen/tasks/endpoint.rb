module HackBoxen
  namespace :hb do

    desc "Copy an endpoint.rb file to the output code directory if the endpoint exists"
    task :endpoint => ['hb:create_required_paths'] do
      endpoints = Dir[File.join(path_to(:hb_engine), '**/*_endpoint.rb')]
      endpoints.each do |srcfile|
        HackBoxen.current_fs.mkpath path_to(:code_dir)
        destfile = File.join(path_to(:code_dir), File.basename(srcfile))
        HackBoxen.current_fs.cp(srcfile, destfile)
      end
    end

  end
end
