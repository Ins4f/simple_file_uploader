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

      uploader.remember_uploader(self, column)
      uploaders[column.to_sym] = uploader
      uploader_options[column.to_sym] = options

      alias_method :read_uploader, :read_attribute
      alias_method :write_uploader, :write_attribute
      public :read_uploader
      public :write_uploader

      before_save{ _uploaders(column).write_identifier! }
      after_create { _uploaders(column).on_create }
      after_destroy { _uploaders(column).on_destroy }
      after_update{ _uploaders(column).on_update(changes[column].first) if changes[column] }

      validate do |obj|
        obj.send(column).errors.each { |error| errors.add(column, error) }
      end

      define_method :"#{column}=" do |value|
        _uploaders(column).column_value = value
      end

      define_method :"#{column}" do
        _uploaders(column)
      end

      define_method :"remove_#{column}!" do
        _uploaders(column).remove
        save!
      end

      define_method :_uploaders do |column|
        @_simple_mounter_instances ||= {}
        @_simple_mounter_instances[column] ||= self.class.uploaders[column].new(self, column)
      end

    end
  end
end