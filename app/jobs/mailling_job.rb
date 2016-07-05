class MaillingJob < Struct.new(:user, :exam)
  def perform
    UserMailer.inform_user_do_exam(user, exam).deliver_now
  end
end
