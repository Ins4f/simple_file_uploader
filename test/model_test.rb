require 'test_helper'

class ModelTest < ActiveSupport::TestCase
  setup do
    @user = User.create
  end

  test 'sample test' do
    @user.avatar = 'asd'
    @user.save
  end

end