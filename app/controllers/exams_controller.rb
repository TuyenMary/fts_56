class ExamsController < ApplicationController
  load_and_authorize_resource
  before_action :authenticate_user!

  def new
    @exam = Exam.new
    @subject = Subject.all
    @exams = Exam.all
  end

  def show
    if @exam.start?
      @time_start = Time.now.to_i
      @exam.update_attributes time_start: @time_start, status: :testing
    else
      @time_start = @exam.time_start
    end
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
