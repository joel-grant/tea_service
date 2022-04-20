class Api::V1::SubscriptionsController < ApplicationController
  def create
    customer_data = Customer.find_by(email: params[:email])
    tea_data = Tea.find(params[:tea_id])
    if customer_data.valid? && tea_data.valid?
      sub = Subscription.create(title: tea_data.title, price: 10, frequency: 1, customer_id: customer_data.id, tea_id: tea_data.id)
      render json: SubscriptionSerializer.new(sub), status: :accepted
    else
      render json: SubscriptionSerializer.error("Subscription could not be created!")
    end
  end
end
