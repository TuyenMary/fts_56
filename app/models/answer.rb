class Answer < ActiveRecord::Base
  include PublicActivity::Model

  belongs_to :question
  tracked owner: ->(controller, model) {controller && controller.current_user}
end
