class User < ActiveRecord::Base
  mount_s3media_server_uploader :avatar, AvatarUploader
  def class_name
    'user'
  end

end