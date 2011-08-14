module HackBoxen
  namespace :hb do

    desc "Ensure all required config options are contained in the WorkingConfig"
    task :validate_working_config do
      WorkingConfig.resolve!
      HackBoxen.verify_dependencies
      # failures = HackBoxen::ConfigValidator.failed_requirements
      # if failures.size > 0
      #   raise "Hackbox environment fails to meet requirements:\n-- " + failures.join("\n-- ") + "\n"
      # end
    end

    desc "Create the required output directories using the filesystem specified by the WorkingConfig"
    task :create_required_paths => [:validate_working_config] do
      output_dirs = [
        path_to(:hb_dataroot),
        path_to(:env_dir),
        path_to(:fixd_dir),
        path_to(:log_dir),
        path_to(:ripd_dir),
        path_to(:rawd_dir),
        path_to(:data_dir)
      ]
      output_dirs.each { |dir| HackBoxen.current_fs.mkpath(dir) unless HackBoxen.current_fs.exists? dir }
    end

    desc "Always save the WorkingConfig out to a file when running a hackbox"
    task :create_working_config => [:create_required_paths] do
      working_config = File.join(path_to(:env_dir), 'working_config.json')
      HackBoxen.current_fs.open(working_config, 'w'){|f| f.write WorkingConfig.to_hash.to_json }
    end

    desc "Execute the main file inside of the current hackbox directory"
    task :init => [:create_working_config] do
      main_file     = path_to(:hb_engine, 'main')
      sh "#{main_file} #{path_to(:hb_dataroot)} #{path_to(:data_dir)}" do |ok,res|
        if !ok
          puts "Processing script failed with #{res}"
        end
      end
    end

  end
end
