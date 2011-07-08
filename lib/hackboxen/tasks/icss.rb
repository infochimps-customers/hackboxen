module HackBoxen
  namespace :hb do

    desc "Copy the Icss file to the output directory in the filesystem specified in the WorkingConfig"
    task :icss => ['hb:create_required_paths'] do
      icss_yaml   = File.join(path_to(:hb_config), "#{WorkingConfig[:protocol]}.icss.yaml")
      if File.exists? icss_yaml
        icss      = YAML.load(File.read icss_yaml)
        icss_json = File.join(path_to(:fixd_dir), "#{WorkingConfig[:protocol]}.icss.json")
        HackBoxen.current_fs.open(File.join(icss_json), 'w') { |f| f.puts icss.to_json }
      end
    end

  end
end
