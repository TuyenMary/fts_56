class UsersController < ApplicationController
  load_resource

  def index
    @search = User.search params[:q]
    @users = @search.result.page(params[:page]).per Settings.number
  end

  def show
    @activities = PublicActivity::Activity.order(created_at: :desc)
      .where(owner_id: @user).page(params[:page])
        .per Settings.number
  end
end
