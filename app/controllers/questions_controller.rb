class QuestionsController < ApplicationController
  load_and_authorize_resource
  skip_authorize_resource :only => :index

  def index
    @search = current_user.questions.search params[:q]
    @questions = @search.result.order(created_at: :desc)
      .page(params[:page]).per Settings.number
  end

  def new
    @subjects = Subject.all
    @question = Question.new
    @question.answers.build
  end

  def create
    custom_question_params = question_params.merge!(state: "waitting")
    @question = Question.new custom_question_params
    if @question.save
      flash[:notice] = t "admin.subject.success"
      redirect_to questions_path
    else
      flash[:alert] = t "admin.subject.danger"
      render :new
    end
  end

  def destroy
    if @question.destroy
      flash[:notice] = t "admin.subject.deletesuccess"
      redirect_to questions_path
    else
      flash[:alert] = t "admin.subject.deletefail"
      redirect_to :back
    end
  end

  private
  def question_params
    params.required(:question).permit :content, :question_type, :subject_id,
      :user_id, answers_attributes: [:id, :correct, :content, :_destroy]
  end
end
