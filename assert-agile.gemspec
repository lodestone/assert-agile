Gem::Specification.new do |s|
  s.name     = "assert-agile"
  s.version  = "0.4"
  s.date     = "2008-11-07"
  s.summary  = "Assert with radioactive spider power."
  s.email    = "matt@kizmeta.com"
  s.homepage = "http://github.com/lodestone/assert-agile"
  s.description = "Assertion Sugar. Better block assertions - Forked from assert2.rubyforge.org"
  s.has_rdoc = true
  s.authors  = ["Matt Petty"]
  s.files    = ["CHANGELOG", "LICENSE",
    "assert-agile.gemspec",
    "init.rb",
    "install.rb",
    "lib/assert_agile.rb", 
    "lib/assert_latest_and_greatest.rb", 
    "lib/ruby_reflector.rb",
    "Rakefile", 
    "README", 
    "tasks/assert_agile_tasks.rb",
    "test/assert_agile_test.rb",
    "uninstall.rb"
  ]
  s.test_files = ["test/assert_agile_test.rb"]
  s.rdoc_options = ["--main", "README"]
  s.extra_rdoc_files = ["CHANGELOG", "README"]
  s.add_dependency("diff-lcs", ["> 0.0.0"])
  s.add_dependency("mime-types", ["> 0.0.0"])
  s.add_dependency("open4", ["> 0.0.0"])
end
