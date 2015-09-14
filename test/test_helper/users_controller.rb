class UsersController < ActionController::Base
  before_filter :set_user, only: [:show, :create, :update, :destroy]
  enable_uploader_api_for :avatar

  def index
  end

  def show
    render json: {avatar: @model.avatar}
  end

  def create
  end

  def update
  end

  def destroy
  end

private
  def set_user
    @model = User.find(params[:id])
  end

end