module SimpleFileUploader
  class UploaderError < SimpleFileUploaderError; end
  class BaseUploader

    attr_accessor :model, :mounted_as, :column_value, :errors

    def initialize(model, mounted_as)
      @errors = []
      @model, @mounted_as = model, mounted_as
      @column_value = @model.read_uploader(@mounted_as)
    end

    def write_identifier!
      @model.write_uploader(@mounted_as, @column_value)
    end

    def plain; column_value; end

    def validate_callback; end

    class << self
      attr_reader :mounted_uploaders

      def remember_uploader(model_class, column)
        @mounted_uploaders ||= []
        @mounted_uploaders << {model_class: model_class.name, column: column}
      end

      def find_uploader_by_uuid(uuid)
        mounted_uploaders.each do |mounted_uploader|
          clazz = mounted_uploader[:model_class].constantize
          found_model = clazz.where(:"#{mounted_uploader[:column]}" => uuid).take
          return found_model.send(:"#{mounted_uploader[:column]}") if found_model.present?
        end if mounted_uploaders.present?
        nil
      end
    end

  end
end