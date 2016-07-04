namespace :my_namespace do
  desc I18n.t("mailers.statistic_exam_desc")
  task statistic_exam: :environment do
    UserMailer.sent_statistic_exam.deliver if Date.today == Date.today.end_of_month
  end
end
