class ExamsController < ApplicationController
  load_and_authorize_resource
  before_action :authenticate_user!

  def new
    @exam = Exam.new
    @subject = Subject.all
  end

  def create
    @exam = current_user.exams.new exam_params
    if @exam.save
      flash[:notice] = t "views.user.success"
      redirect_to root_path
    else
      flash[:alert] = t "views.user.danger"
      redirect_to :back
    end
  end

  private
  def exam_params
    params.require(:exam).permit :subject_id
  end
end
