module S3MediaClient
  module Uploader
    class UploaderError < S3MediaClientError; end
    class Base
      attr_accessor :model, :mounted_as

      def initialize(model, mounted_as)
        @model, @mounted_as = model, mounted_as
      end

    end
  end
end