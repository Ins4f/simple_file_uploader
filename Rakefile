require 'rake'
require 'rake/testtask'
require 'rdoc/task'

desc 'Test the S3 Multipart Api Plugin.'
Rake::TestTask.new(:test) do |t|
  t.libs << 'lib' << 'test'
  t.pattern = 'test/**/*_test.rb'
  t.verbose = true
end