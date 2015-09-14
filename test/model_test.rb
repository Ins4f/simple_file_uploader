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

  test 'sample validation test' do
    @user.avatar = 'errored_uuid'
    assert_equal false, @user.save
    assert_equal 'Invalid file name identitier', @user.errors[:avatar].first
  end

end