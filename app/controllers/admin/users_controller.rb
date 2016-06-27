class Admin::UsersController < ApplicationController
  load_and_authorize_resource

  def destroy
    if @user.destroy
      flash[:notice] = t "views.user.success"
      redirect_to users_path
    else
      flash[:alert] = t "views.user.danger"
      redirect_to :back
    end
  end
end
