class Subject < ActiveRecord::Base
  acts_as_paranoid

  has_many :exams
  has_many :questions, dependent: :destroy

  after_save :notify_user

  private
  def notify_user
    NotifyUser.new(self).notificate_user
  end
end
