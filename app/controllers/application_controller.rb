class ApplicationController < ActionController::API
  def index
    customer = Customer.find(params[:customer_id])
    subs = customer.subscriptions
    render json: SubscriptionSerializer.new(subs)
  end
end
