module SimpleFileUploader
  module ActiveRecord

    def uploaders
      @uploaders ||= superclass.respond_to?(:uploaders) ? superclass.uploaders.dup : {}
    end

    def uploader_options
      @uploader_options ||= superclass.respond_to?(:uploader_options) ? superclass.uploader_options.dup : {}
    end

    # Input Params:
    # @required column - [string] the coolumn name in the model the uuid of s3_media_server stored
    # @required uploader - [class] the class of Uploader used for field as uploader
    def mount_simple_uploader(column, uploader, options = {})

      uploaders[column.to_sym] = uploader
      uploader_options[column.to_sym] = options

      alias_method :read_uploader, :read_attribute
      alias_method :write_uploader, :write_attribute
      public :read_uploader
      public :write_uploader

      before_save :"write_#{column}_identifier"
      validate :"run_#{column}_validate_callback"
      after_save :"run_#{column}_after_save_callbacks"
      after_destroy :"run_#{column}_after_destroy_callbacks"

      define_method :"#{column}=" do |value|
        _uploaders(column).file_name_identifier = value
      end

      define_method :"#{column}" do
        _uploaders(column)
      end

      define_method :"run_#{column}_validate_callback" do
        _uploaders(column).write_identifier!
      end

      define_method :"write_#{column}_identifier" do
        _uploaders(column).validate_callback
      end

      define_method :"run_#{column}_after_save_callbacks" do
        _uploaders(column).run_after_save_callbacks
      end

      define_method :"run_#{column}_after_destroy_callbacks" do
        _uploaders(column).run_after_de stroy_callbacks
      end

      define_method :"store_#{column}!" do
        _uploaders(column).store!
      end

      define_method :"#{column}_delete" do
        _uploaders(column).delete
      end

      define_method :_uploaders do |column|
        @_simple_mounter_instances ||= {}
        @_simple_mounter_instances[column] ||= self.class.uploaders[column].new(self, column)
      end

    end
  end
end