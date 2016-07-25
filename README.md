# Simple File Uploader
##### Designed for easy uploader for rails app s3 media server.
---

### Installation 
```sh
gem 'simple_file_uploader'
```

### Example of use

```sh
class AvatarUploader < SimpleFileUploader::BaseUploader

  def on_update(old_column_value)
  end

  def on_create
  end

  def on_destroy
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

end




class User < ActiveRecord::Base
  mount_simple_uploader :avatar, AvatarUploader
  
  def class_name
    'user'
  end
end


@user = User.create
@user.update(avatar: 'avatar column value') # SecureRandom.uuid for example
print @user.avatar.as_json 
=> { url: 'http://google.com/logo.png', thumb_url: 'http://google.com/logo_thumb.png' }

```
