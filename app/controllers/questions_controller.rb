class QuestionsController < ApplicationController
  load_resource

  def index
    @questions = current_user.questions.order(created_at: :desc)
      .page(params[:page]).per Settings.number
  end

  def new
    @subjects = Subject.all
    @question = Question.new
    @question.answers.build
  end

  def create
    @question = Question.new question_params
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
      :user_id, :state, answers_attributes: [:id, :correct, :content, :_destroy]
  end
end
