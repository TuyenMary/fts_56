class Admin::SubjectsController < ApplicationController
  load_and_authorize_resource

  def new
    @subject = Subject.new
  end

  def create
    authorize! :create, @subject
    @subject = Subject.new subject_params
    if @subject.save
      flash[:notice] = t "admin.subject.success"
      redirect_to root_path
    else
      flash[:alert] = t "admin.subject.danger"
      render :new
    end
  end

  private
  def subject_params
    params.require(:subject).permit :name, :description
  end
end
