class AvatarUploader < SimpleFileUploader::BaseUploader

  def on_update(old_column_value)
  end

  def on_create
  end

  def on_destroy
  end

  def as_json(options = {})
  end

  def remove
  end

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