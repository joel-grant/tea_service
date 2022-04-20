require 'rails_helper'

RSpec.describe 'Subscription API Endpoints' do
  describe 'POST /subscription' do
    it 'creates a new subscription for a customer' do
      user_data = "test@person1.com"
      tea_data = 1
      c1 = Customer.create(first_name: "Test", last_name: "Person1", email: "test@person1.com", address: "12345 Something Road")
      t1 = Tea.create(title: "Earl Grey", description: "Black Tea", temperature: 110, brew_time: 3)
      post '/api/v1/subscriptions', params: { email: c1.email, tea_id: t1.id }
      result = JSON.parse(response.body, symbolize_names: true)

      expect(response).to be_successful

      expect(result).to be_a Hash
      expect(result[:data]).to be_a Hash

      expect(result[:data]).to have_key(:id)

      expect(result[:data]).to have_key(:type)
      expect(result[:data][:type]).to eq("subscription")

      expect(result[:data]).to have_key(:attributes)

      expect(result[:data][:attributes]).to have_key(:id)
      expect(result[:data][:attributes]).to have_key(:title)
      expect(result[:data][:attributes]).to have_key(:price)
      expect(result[:data][:attributes]).to have_key(:status)
      expect(result[:data][:attributes]).to have_key(:frequency)
      expect(result[:data][:attributes][:title]).to eq(t1.title)
    end
  end
end
