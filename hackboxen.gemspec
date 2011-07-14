# Generated by jeweler
# DO NOT EDIT THIS FILE DIRECTLY
# Instead, edit Jeweler::Tasks in Rakefile, and run 'rake gemspec'
# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{hackboxen}
  s.version = "0.1.5"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["kornypoet", "Ganglion", "bollacker"]
  s.date = %q{2011-07-14}
  s.description = %q{A simple framework to assist in standardizing the data-munging input/output process.}
  s.email = %q{travis@infochimps.com}
  s.executables = ["hb-install", "hb-scaffold", "hb-runner"]
  s.extra_rdoc_files = [
    "LICENSE.txt",
    "README.textile"
  ]
  s.files = [
    "CHANGELOG.textile",
    "Gemfile",
    "Gemfile.lock",
    "LICENSE.txt",
    "README.textile",
    "Rakefile",
    "VERSION",
    "bin/describe.rb",
    "bin/hb-install",
    "bin/hb-runner",
    "bin/hb-scaffold",
    "hackboxen.gemspec",
    "lib/gemfiles/Gemfile.jruby-1.6.2.default",
    "lib/gemfiles/Gemfile.ruby-1.8.7.default",
    "lib/gemfiles/Gemfile.ruby-1.9.2.default",
    "lib/hackboxen.rb",
    "lib/hackboxen/tasks.rb",
    "lib/hackboxen/tasks/endpoint.rb",
    "lib/hackboxen/tasks/icss.rb",
    "lib/hackboxen/tasks/init.rb",
    "lib/hackboxen/tasks/install.rb",
    "lib/hackboxen/tasks/mini.rb",
    "lib/hackboxen/tasks/scaffold.rb",
    "lib/hackboxen/template.rb",
    "lib/hackboxen/template/Rakefile.erb",
    "lib/hackboxen/template/config.yaml.erb",
    "lib/hackboxen/template/endpoint.rb.erb",
    "lib/hackboxen/template/icss.yaml.erb",
    "lib/hackboxen/template/main.erb",
    "lib/hackboxen/utils.rb",
    "lib/hackboxen/utils/README_ConfigValidator.textile",
    "lib/hackboxen/utils/config_validator.rb",
    "lib/hackboxen/utils/logging.rb",
    "lib/hackboxen/utils/paths.rb",
    "spec/install_spec.rb"
  ]
  s.homepage = %q{http://github.com/infochimps/hackboxen}
  s.licenses = ["MIT"]
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.7}
  s.summary = %q{A simple framework to assist in standardizing the data-munging input/output process.}
  s.test_files = [
    "spec/install_spec.rb"
  ]

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<swineherd>, [">= 0.0.4"])
      s.add_runtime_dependency(%q<configliere>, [">= 0.4.6"])
      s.add_runtime_dependency(%q<rake>, [">= 0.8.7"])
      s.add_development_dependency(%q<shoulda>, [">= 0"])
      s.add_development_dependency(%q<bundler>, ["~> 1.0.0"])
      s.add_development_dependency(%q<jeweler>, ["~> 1.5.2"])
      s.add_development_dependency(%q<rcov>, [">= 0"])
    else
      s.add_dependency(%q<swineherd>, [">= 0.0.4"])
      s.add_dependency(%q<configliere>, [">= 0.4.6"])
      s.add_dependency(%q<rake>, [">= 0.8.7"])
      s.add_dependency(%q<shoulda>, [">= 0"])
      s.add_dependency(%q<bundler>, ["~> 1.0.0"])
      s.add_dependency(%q<jeweler>, ["~> 1.5.2"])
      s.add_dependency(%q<rcov>, [">= 0"])
    end
  else
    s.add_dependency(%q<swineherd>, [">= 0.0.4"])
    s.add_dependency(%q<configliere>, [">= 0.4.6"])
    s.add_dependency(%q<rake>, [">= 0.8.7"])
    s.add_dependency(%q<shoulda>, [">= 0"])
    s.add_dependency(%q<bundler>, ["~> 1.0.0"])
    s.add_dependency(%q<jeweler>, ["~> 1.5.2"])
    s.add_dependency(%q<rcov>, [">= 0"])
  end
end

