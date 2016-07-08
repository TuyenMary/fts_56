class Admin::ExamsController < ApplicationController
  load_and_authorize_resource
  def index
    @search = Exam.search params[:q]
    @exams = @search.result.order(created_at: :desc)
      .page(params[:page]).per Settings.number
  end

  def show
  end

  def update
    if params[:commit] == "checked" && @exam.checked!
      flash.now[:success] = t "exams.show.success"
      redirect_to admin_exams_path
    else
      flash.now[:danger] = t "exams.show.fail"
      redirect_to :back
    end
  end
end
