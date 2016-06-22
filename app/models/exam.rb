class Exam < ActiveRecord::Base
  belongs_to :subject
  belongs_to :user

  has_many :results, dependent: :destroy
  has_many :questions, through: :results
end
