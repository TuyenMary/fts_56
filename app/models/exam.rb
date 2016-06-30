class Exam < ActiveRecord::Base
  include PublicActivity::Model

  enum status: [:start, :testing, :saved, :uncheck, :checked]

  belongs_to :subject
  belongs_to :user

  has_many :results, dependent: :destroy
  has_many :questions, through: :results

  tracked  owner: ->(controller, model) {controller && controller.current_user}

  before_create :create_questions

  accepts_nested_attributes_for :results

  private
  def create_questions
    self.questions = subject.questions.all
    self.question_number = self.questions.size
    if self.questions.size == Settings.question_number
      self.duration = Settings.duration1
    else
      self.duration = Settings.duration2
    end
  end
end
