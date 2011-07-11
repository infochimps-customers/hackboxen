module HackBoxen
  namespace :hb do

    desc "Copy the Icss file to the output directory in the filesystem specified in the WorkingConfig"
    task :icss => ['hb:create_required_paths'] do
      icss_yamls    = Dir[File.join(path_to(:hb_config), '**/*.icss.yaml')]
      icss_yamls.each do |icss_yaml|
        icss_hsh    = YAML.load(File.read(icss_yaml))
        if icss_hsh
          icss_json = File.join(path_to(:fixd_dir), "#{icss_hsh['protocol']}.icss.json")
          HackBoxen.current_fs.open(File.join(icss_json), 'w') { |f| f.puts icss_hsh.to_json }
        end
      end
    end

  end
end
