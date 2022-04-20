class Customer < ApplicationRecord
  validates_presence_of :first_name, :last_name, :email, :address, presence: true
  has_many :subscriptions
  has_many :teas, through: :subscriptions

  def get_active_subscriptions
    subscriptions.where(status: :active)
  end

  def get_cancelled_subscriptions
    subscriptions.where(status: :cancelled)
  end
end
