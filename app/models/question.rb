class Question < ActiveRecord::Base
  belongs_to :subject
  belongs_to :user

  has_many :answers, dependent: :destroy
  has_many :results, dependent: :destroy
  has_many :exams, through: :results
end
