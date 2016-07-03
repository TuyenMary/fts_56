class Result < ActiveRecord::Base
  belongs_to :question
  belongs_to :exam
  belongs_to :answer

  scope :correct_answers, -> do
    joins(:answer).where answers:{correct: true}
  end
end
