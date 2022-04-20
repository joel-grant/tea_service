class Api::V1::SubscriptionsController < ApplicationController
  def index
    customer = Customer.find(params[:customer_id])
    if params[:status] == "active"
      subs = customer.get_active_subscriptions
    elsif params[:status] == "cancelled"
      subs = customer.get_cancelled_subscriptions
    else
      subs = customer.subscriptions
    end
    render json: SubscriptionSerializer.new(subs)
  end

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

  def destroy
    sub = Subscription.find(params[:id])
    if sub.valid?
      sub.update(status: 1)
      render json: SubscriptionSerializer.new(sub)
    else
      render json: SubscriptionSerializer.error("Subscription could not be cancelled!")
    end
  end
end
