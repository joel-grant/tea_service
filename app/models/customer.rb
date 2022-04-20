class Customer < ApplicationRecord
  validates_presence_of :first_name, :last_name, :email, :address, presence: true
  has_many :subscriptions
  has_many :teas, through: :subscriptions
end
