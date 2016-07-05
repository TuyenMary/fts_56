class EmailWorker
  include Sidekiq::Worker
  def perform exam_id
    exam = Exam.find exam_id
    UserMailer.send_exam_result(exam).deliver_now
  end
end
