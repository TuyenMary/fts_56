class Exam < ActiveRecord::Base
  belongs_to :subject
  belongs_to :user

  has_many :results, dependent: :destroy
  has_many :questions, through: :results

  before_create :create_questions

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
