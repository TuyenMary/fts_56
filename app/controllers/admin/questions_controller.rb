class Admin::QuestionsController < ApplicationController
  load_and_authorize_resource
  before_action :load_subject, only: [:index, :edit, :update]

  def index
    @questions = @questions.order(created_at: :desc)
      .page(params[:page]).per Settings.number
    @question = Question.new
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

  def edit
  end

  def update
    custom_question_params = question_params.merge!(state: "accepted")
    if @question.update_attributes custom_question_params
      flash[:notice] = t "admin.subject.success"
      redirect_to admin_question_path(@question)
    else
      flash[:alert] = t "admin.subject.danger"
      redirect_to :back
    end
  end

  def destroy
    if @question.destroy
      flash[:notice] = t "admin.subject.deletesuccess"
      redirect_to admin_questions_path
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

  def load_subject
    @subjects = Subject.all
  end
end
