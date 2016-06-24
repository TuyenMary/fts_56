class Admin::SubjectsController < ApplicationController
  load_and_authorize_resource

  def index
    @subjects = Subject.order(created_at: :desc)
      .page(params[:page]).per Settings.number
  end

  def show
  end

  def new
    @subject = Subject.new
  end

  def create
    authorize! :create, @subject
    @subject = Subject.new subject_params
    if @subject.save
      flash[:notice] = t "admin.subject.success"
      redirect_to admin_subjects_path
    else
      flash[:alert] = t "admin.subject.danger"
      render :new
    end
  end

  def edit
  end

  def update
    authorize! :update, @subject
    if @subject.update_attributes subject_params
      flash[:notice] = t "admin.subject.success"
      redirect_to admin_subject_path
    else
      flash[:alert] = t "admin.subject.danger"
      redirect_to :back
    end
  end

  def destroy
    authorize! :destroy, @subject
    if @subject.destroy
      flash[:notice] = t "admin.subject.deletesuccess"
      redirect_to admin_subjects_path
    else
      flash[:alert] = t "admin.subject.deletefail"
      redirect_to :back
    end
  end

  private
  def subject_params
    params.require(:subject).permit :name, :description
  end
end
