class UserMailer < ApplicationMailer
  def inform_user_do_exam user, exam
    @user = user
    mail to: user.email, subject: t("mailers.inform")
  end

  def notify_user_after_subject_created user, subject
    @user = user
    @subject = subject
    mail to: user.email, subject: "#{subject.name}"
  end
end
