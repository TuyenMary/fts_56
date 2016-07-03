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

  def sent_statistic_exam
    @users = User.all
    @users.each do |user|
      @exams = Exam.statistic_exam user.id, Date.today
      mail to: user.mail, subject: t "mailers.statistic"
    end
  end
end
