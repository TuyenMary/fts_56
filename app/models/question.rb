class Question < ActiveRecord::Base
  include PublicActivity::Model

  acts_as_paranoid

  enum state: [:waitting, :accepted]
  enum question_type: [:single, :multiple, :text]

  tracked owner: ->(controller, model) {controller && controller.current_user}

  belongs_to :subject
  belongs_to :user

  has_many :answers, dependent: :destroy
  has_many :results, dependent: :destroy
  has_many :exams, through: :results

  accepts_nested_attributes_for :answers, allow_destroy: true,
    reject_if: proc {|answer| answer[:content].blank?}

  validates :content, presence: true

  def subject
    Subject.unscoped {super}
  end
end
