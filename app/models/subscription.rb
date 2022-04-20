class Subscription < ApplicationRecord
  validates_presence_of :title, :price, :status, :frequency, presence: true
  belongs_to :tea
  belongs_to :customer
  enum status: [ :active, :inactive ]
  enum frequency: [ :weekly, :biweekly, :monthly ]
end
