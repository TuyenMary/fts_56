class Admin::QuestionsController < ApplicationController
  load_and_authorize_resource

  def index
    @questions = @questions.order(created_at: :desc)
      .page(params[:page]).per Settings.number
    @question = Question.new
    @subjects = Subject.all
    @question.answers.build
  end

  def new
  end

  def create
    custom_question_params = question_params.merge!(state: "accepted")
    @question = Question.new custom_question_params
    if @question.save
      flash[:notice] = t "admin.subject.success"
      redirect_to admin_questions_path
    else
      flash[:alert] = t "admin.subject.danger"
      redirect_to :back
    end
  end

  private
  def question_params
    params.required(:question).permit :content, :question_type, :subject_id,
      :user_id, answers_attributes: [:id, :correct, :content, :_destroy]
  end
end
