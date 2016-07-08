class ExamsController < ApplicationController
  load_and_authorize_resource
  before_action :authenticate_user!
  before_action :user_validation, only: [:show]

  def index
    @exam = Exam.new
    @subject = Subject.all
    @search = current_user.exams.search params[:q]
    @exams = @search.result.order(created_at: :desc)
      .page(params[:page]).per Settings.number
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
      flash[:notice] = t "exams.show.success"
      redirect_to exams_path
    else
      flash[:alert] = t "exams.show.fail"
      redirect_to :back
    end
  end

  def update
    @exam.status = params[:commit] == "finish" ? :uncheck : :saved
    @exam.time_end = Time.now.to_i
    if @exam.update_attributes exam_params
      flash.now[:success] = t "exams.show.success"
      redirect_to exams_path
    else
      flash.now[:danger] = t "exams.show.fail"
      redirect_to :back
    end
  end

  private
  def exam_params
    params.require(:exam).permit :subject_id,
      results_attributes: [:id, :answer_id]
  end

  def user_validation
    if current_user.exams.find_by(id: params[:id]).nil?
      redirect_to exams_path
      flash[:notice] = t "exams.show.notice"
    end
  end
end
