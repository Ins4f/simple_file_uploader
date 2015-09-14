# -*- encoding: utf-8 -*-
require File.expand_path('../lib/s3_media_client/version', __FILE__)

Gem::Specification.new do |s|
  s.name = 's3_media_client'
  s.version = S3MediaClient::VERSION

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