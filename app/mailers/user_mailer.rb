class UserMailer < ApplicationMailer
  def inform_user_do_exam user, exam
    @user = user
    mail to: user.email, subject: t "mailers.inform"
  end
end
