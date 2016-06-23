class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable,
    :recoverable, :rememberable, :trackable, :validatable

  has_many :activities, dependent: :destroy
  has_many :exams, dependent: :destroy
  has_many :results, through: :exams
  has_many :questions, dependent: :destroy
end
