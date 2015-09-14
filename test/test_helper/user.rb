class User < ActiveRecord::Base
  mount_simple_uploader :avatar, AvatarUploader
  def class_name
    'user'
  end

end