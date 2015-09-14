require 'simple_file_uploader/version'

module SimpleFileUploader
  class SimpleFileUploaderError < RuntimeError; end
  require 'simple_file_uploader/uploader'
  require 'simple_file_uploader/active_record'
end

ActiveRecord::Base.extend SimpleFileUploader::ActiveRecord