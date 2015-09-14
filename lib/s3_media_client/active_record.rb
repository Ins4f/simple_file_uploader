module S3MediaClient
  module ActiveRecord

    def s3_uploaders
      @s3_uploaders ||= superclass.respond_to?(:s3_uploaders) ? superclass.s3_uploaders.dup : {}
    end

    def s3_uploader_options
      @s3_uploader_options ||= superclass.respond_to?(:s3_uploader_options) ? superclass.s3_uploader_options.dup : {}
    end

    # Input Params:
    # @required column - [string] the coolumn name in the model the uuid of s3_media_server stored
    # @required uploader - [class] the class of Uploader used for field as uploader
    def mount_s3media_server_uploader(column, uploader, options = {})

      uploader = build_uploader(uploader)

      s3_uploaders[column.to_sym] = uploader
      s3_uploader_options[column.to_sym] = options

      alias_method :read_s3_uploader, :read_attribute
      alias_method :write_s3_uploader, :write_attribute
      public :read_s3_uploader
      public :write_s3_uploader

      before_save :"write_#{column}_identifier"
      after_save :"run_#{column}_after_save_callbacks"
      after_destroy :"run_#{column}_after_destroy_callbacks"

      define_method "#{column}=".to_sym do |value|
        s3_uploaders[column].original_filename = value
      end

      define_method "#{column}".to_sym do
        s3_uploaders[column]
      end

      define_method "write_#{column}_identifier".to_sym do
        s3_uploaders[column].write_identifier!
      end

      define_method "run_#{column}_after_save_callbacks".to_sym do
        s3_uploaders[column].run_after_save_callbacks
      end

      define_method "run_#{column}_after_destroy_callbacks".to_sym do
        s3_uploaders[column].run_after_destroy_callbacks
      end

      define_method "store_#{column}!".to_sym do
        s3_uploaders[column].store!
      end

      define_method "#{column}_uploaded".to_sym do
        s3_uploaders[column].complete_upload
      end

      define_method "#{column}_delete".to_sym do
        s3_uploaders[column].delete
      end

    end
  end
end