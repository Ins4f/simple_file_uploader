module SimpleFileUploader
  class UploaderError < SimpleFileUploaderError; end
  class BaseUploader
    attr_accessor :model, :mounted_as, :file_name_identifier, :errors

    def initialize(model, mounted_as)
      @errors = []
      @model, @mounted_as = model, mounted_as
    end

    def write_identifier!
      @model.write_uploader(@mounted_as, file_name_identifier)
    end

    def run_after_save_callbacks; end

    def validate_callback; end
  end
end