class AvatarUploader < SimpleFileUploader::BaseUploader

  # here resolve command for asynk gem
  def resolve
    @resolved_data ||= { url: 'http://google.com/logo.png', thumb_url: 'http://google.com/logo_thumb.png' }
  end

  def serializable_hash(options = {})
    resolve
  end

  def as_json(options = {})
    serializable_hash
  end

  def validate_callback
    errors << 'Invalid file name identitier' if @file_name_identifier == 'errored_uuid'
  end

end