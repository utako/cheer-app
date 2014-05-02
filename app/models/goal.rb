class Goal < ActiveRecord::Base
  validates :body, :owner, presence: true

  belongs_to :owner, class_name: "User", foreign_key: :user_id
end
