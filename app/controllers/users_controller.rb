class UsersController < ApplicationController

  def index
    @users = User.order(remember_created_at: :desc)
      .page(params[:page]).per Settings.number
  end
end
