class Subscription < ApplicationRecord
  validates_presence_of :title, :price, :status, :frequency, presence: true
  belongs_to :tea
  belongs_to :customer
end
