require 'simple_file_uploader/version'

module SimpleFileUploader
  class SimpleFileUploaderError < RuntimeError; end
end

require 'simple_file_uploader/base_uploader'
require 'simple_file_uploader/active_record'

ActiveRecord::Base.extend SimpleFileUploader::ActiveRecord