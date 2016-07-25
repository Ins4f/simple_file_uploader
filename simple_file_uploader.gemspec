# -*- encoding: utf-8 -*-
require File.expand_path('../lib/simple_file_uploader/version', __FILE__)

Gem::Specification.new do |s|
  s.name = 'simple_file_uploader'
  s.version = SimpleFileUploader::VERSION

  s.license       = "MIT"
  s.required_ruby_version = '>= 2.2.0'
  s.authors = ['Danil Nurgaliev']
  s.summary = 'Designed for easy uploader for rails app s3 media server.'
  s.email = 'jkonalegi@gmail.com'
  s.files = Dir['{lib}/**/*', 'README.md']
  s.has_rdoc = false
  s.extra_rdoc_files = ['README.md']

  s.add_dependency 'bunny'
  s.add_development_dependency 'rails', '>= 4.0.0'
  s.add_development_dependency 'sqlite3'
  s.add_development_dependency 'faker'
end