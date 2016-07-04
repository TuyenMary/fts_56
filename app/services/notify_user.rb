class NotifyUser
  def initialize subject
    @subject = subject
  end

  def notificate_user
    @users = User.all
    @users.each do |user|
      UserMailer.notify_user_after_subject_created user, @subject
    end
  end
end
