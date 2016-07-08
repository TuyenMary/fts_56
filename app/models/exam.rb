class Exam < ActiveRecord::Base
  include PublicActivity::Model

  enum status: [:start, :testing, :saved, :uncheck, :checked]

  belongs_to :subject
  belongs_to :user

  has_many :results, dependent: :destroy
  has_many :questions, through: :results

  tracked  owner: ->(controller, model) {controller && controller.current_user}

  scope :statistic_exam, -> (user_id, time_month) {where("user_id = ? and
    created_at >= ? and created_at < ?", user_id, time_month.beginning_of_month,
    time_month.end_of_month)}

  before_create :create_questions
  after_save :inform_of_user
  after_update :calculate_time_from_create_to_update, :send_result

  accepts_nested_attributes_for :results

  def subject
    Subject.unscoped {super}
  end

  private
  def create_questions
    self.questions = subject.questions.all
    self.question_number = self.questions.size
    if self.questions.size == Settings.question_number
      self.duration = Settings.duration1
    else
      self.duration = Settings.duration2
    end
  end

  def inform_of_user
    mailling_job = MaillingJob.new self.user, self
    Delayed::Job.enqueue mailling_job, 1, 8.hours.from_now
  end

  def calculate_time_from_create_to_update
    time_from_start = self.updated_at - self.created_at
    if time_from_start.to_i < Settings.time_limit
      if  Delayed::Job.find_by(created_at: self.created_at).present?
        Delayed::Job.find_by(created_at: self.created_at).delete
      end
    end
  end

  def send_result
    EmailWorker.perform_async id if checked?
  end
end
