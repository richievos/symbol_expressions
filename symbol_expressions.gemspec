# Generated by jeweler
# DO NOT EDIT THIS FILE DIRECTLY
# Instead, edit Jeweler::Tasks in Rakefile, and run the gemspec command
# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{symbol_expressions}
  s.version = "0.1.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Groupon, Inc."]
  s.date = %q{2010-02-17}
  s.description = %q{A hefty extension to and complement of Symbol#to_proc.}
  s.email = %q{dev@groupon.com}
  s.extra_rdoc_files = [
    "LICENSE",
     "README.rdoc"
  ]
  s.files = [
    ".document",
     ".gitignore",
     "LICENSE",
     "README.rdoc",
     "Rakefile",
     "VERSION",
     "lib/symbol_expressions.rb",
     "spec/spec.opts",
     "spec/spec_helper.rb",
     "spec/symbol_expressions_spec.rb"
  ]
  s.homepage = %q{http://github.com/evanfarrar/symbol_expressions}
  s.rdoc_options = ["--charset=UTF-8"]
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.5}
  s.summary = %q{A hefty extension of and complement to Symbol#to_proc.}
  s.test_files = [
    "spec/spec_helper.rb",
     "spec/symbol_expressions_spec.rb"
  ]

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<rspec>, [">= 1.2.6"])
      s.add_development_dependency(%q<yard>, [">= 0"])
    else
      s.add_dependency(%q<rspec>, [">= 1.2.6"])
      s.add_dependency(%q<yard>, [">= 0"])
    end
  else
    s.add_dependency(%q<rspec>, [">= 1.2.6"])
    s.add_dependency(%q<yard>, [">= 0"])
  end
end

