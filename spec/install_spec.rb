require 'rspec'
require 'rake'

describe "rake config task" do
  before :each do
    @rake = Rake::Application.new
    Rake.application = @rake
    @rake.rake_require(File.expand_path File.join(File.dirname(__FILE__), '..', 'test'))
    @task_name = 'config'
    @cfg_file  = File.join(ENV['HOME'],'.hackbox', 'hackbox.yaml')
  end

  it "should create the config file '/.hackbox/hackbox.yaml' in your home directory" do
    @rake[@task_name].invoke
    File.exists? @cfg_file
  end

  it "should populate the config file with default keys for dataroot, coderoot, s3_filesystem, and requires" do
    @default_keys = %w[ dataroot coderoot s3_filesystem requires ]
    @rake[@task_name].invoke
    @test_hash = YAML.load File.read(@cfg_file)
    @default_keys.each do |key|
      @test_hash.keys.should include key
    end
  end

  it "should be able to set the dataroot and coderoot value in the config file" do
    dataroot = "/data/foo"
    coderoot = "/code/foo"
    @rake[@task_name].invoke(dataroot, coderoot)
    @test_hash = YAML.load File.read(@cfg_file)
    @test_hash['dataroot'].should == dataroot
    @test_hash['coderoot'].should == coderoot
  end

end
