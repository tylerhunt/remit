require 'rubygems'
require 'rake/clean'
require 'rake/gempackagetask'
require 'rake/rdoctask'

desc 'Default: package gem.'
task :default => :gem

spec = Gem::Specification.new do |spec|
  spec.name = 'remit'
  spec.version = '0.0.1'
  spec.summary = "An API for using the Amazon Flexible Payment Service (FPS)."
  spec.author = 'Tyler Hunt'
  spec.email = 'tyler@tylerhunt.com'
  spec.homepage = 'http://tylerhunt.com/'
  spec.rubyforge_project = 'remit'
  spec.platform = Gem::Platform::RUBY
  spec.files = FileList['{bin,lib}/**/*'].to_a
  spec.require_path = 'lib'
  spec.test_files = FileList['{spec}/**/{*spec.rb,*helper.rb}'].to_a
  spec.has_rdoc = true
  spec.extra_rdoc_files = ['README', 'LICENSE']
  spec.add_dependency('relax', '>= 0.0.5')
end

Rake::GemPackageTask.new(spec) do |package| 
  package.need_tar = true 
end 

Rake::RDocTask.new do |rdoc|
  rdoc.title = 'Relax Documentation'
  rdoc.main = 'README'
  rdoc.rdoc_files.include('README', 'LICENSE', 'lib/**/*.rb')
end
