class Tea < ApplicationRecord
  validates_presence_of :title, :description, :temperature, :brew_time, presence: true
  has_many :subscriptions
  has_many :customers, through: :subscriptions
end
