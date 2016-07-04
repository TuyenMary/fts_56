class Subject < ActiveRecord::Base
  has_many :exams, dependent: :destroy
  has_many :questions, dependent: :destroy

  after_save :notify_user

  private
  def notify_user
    NotifyUser.new(self).notificate_user
  end
end
