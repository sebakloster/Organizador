class Note
  include Mongoid::Document
  include Mongoid::Timestamps

  fields :body, type: String

  belongs_to :user
  belongs_to :task

  validates :body, presence: true
end
