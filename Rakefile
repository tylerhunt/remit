require 'rubygems'
require 'rake/clean'
require 'rake/gempackagetask'
require 'rake/rdoctask'
require 'spec/rake/spectask'

desc 'Default: package gem.'
task :default => :gem

spec = Gem::Specification.new do |spec|
  spec.name               = 'remit'
  spec.version            = '0.0.1'
  spec.summary            = "An API for using the Amazon Flexible Payment Service (FPS)."
  spec.author             = 'Tyler Hunt'
  spec.email              = 'tyler@tylerhunt.com'
  spec.homepage           = 'http://tylerhunt.com/'
  spec.rubyforge_project  = 'remit'
  spec.platform           = Gem::Platform::RUBY
  spec.files              = FileList['{bin,lib}/**/*'].to_a
  spec.require_path       = 'lib'
  spec.test_files         = FileList['{spec}/**/{*spec.rb,*helper.rb}'].to_a
  spec.has_rdoc           = true
  spec.extra_rdoc_files   = ['README', 'LICENSE']
  spec.add_dependency('relax', '>= 0.0.3')
end

Rake::GemPackageTask.new(spec) do |package| 
  package.need_tar = true 
end 

Rake::RDocTask.new do |rdoc|
  rdoc.title    = 'Remit Documentation'
  rdoc.main     = 'README'
  rdoc.rdoc_dir = 'rdoc'
  rdoc.rdoc_files.include('README', 'LICENSE', 'lib/**/*.rb')
  rdoc.options << '--inline-source'
  rdoc.options << '--line-numbers'
end

task :spec do
  Rake::Task["spec:units"].invoke
end

namespace :spec do
  desc "Run unit specs."
  Spec::Rake::SpecTask.new(:units) do |t|
    t.spec_opts   = ['--colour --format progress --loadby mtime --reverse']
    t.spec_files  = FileList['spec/units/**/*_spec.rb']
  end

  desc "Run integration specs. Requires AWS_ACCESS_KEY and AWS_SECRET_KEY."
  Spec::Rake::SpecTask.new(:integrations) do |t|
    t.spec_opts   = ['--colour --format progress --loadby mtime --reverse']
    t.spec_files  = FileList['spec/integrations/**/*_spec.rb']
  end
end

Spec::Rake::SpecTask.new(:doc) do |t|
  t.spec_opts   = ['--format specdoc --dry-run --colour']
  t.spec_files  = FileList['spec/**/*_spec.rb']
end
