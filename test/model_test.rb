require 'test_helper'

class ModelTest < ActiveSupport::TestCase
  setup do
    @user = User.create
  end

  test 'sample test' do
    @user.avatar = 'asd'
    @user.save

    assert '{"url":"http://google.com/logo.png","thumb_url":"http://google.com/logo_thumb.png"}', @user.avatar.to_json
  end

end