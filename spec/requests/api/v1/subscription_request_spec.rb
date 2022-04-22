require 'rails_helper'

RSpec.describe 'Subscription API Endpoints' do
  describe 'POST /subscription' do
    it 'creates a new subscription for a customer' do
      user_data = "test@person1.com"
      tea_data = 1
      c1 = Customer.create(first_name: "Test", last_name: "Person1", email: "test@person1.com", address: "12345 Something Road")
      t1 = Tea.create(title: "Earl Grey", description: "Black Tea", temperature: 110, brew_time: 3)
      post "/api/v1/customers/#{c1.id}/subscriptions", params: { tea_id: t1.id }
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

  describe 'DELETE /subscriptions' do
    it 'cancels the subscription for a customer' do
      c1 = Customer.create(first_name: "Test", last_name: "Person1", email: "test@person1.com", address: "12345 Something Road")
      t1 = Tea.create(title: "Earl Grey", description: "Black Tea", temperature: 110, brew_time: 3)
      sub = Subscription.create(title: "Earl Grey", price: 10, status: 0, frequency: 1, tea_id: t1.id, customer_id: c1.id)
      patch  "/api/v1/subscriptions/#{sub.id}"
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

  describe 'GET /subscriptions' do
    it 'shows all subscriptions whether active or cancelled' do
      c1 = Customer.create(first_name: "Test", last_name: "Person1", email: "test@person1.com", address: "12345 Something Road")

      t1 = Tea.create(title: "Earl Grey", description: "Black Tea", temperature: 110, brew_time: 3)
      t2 = Tea.create(title: "Green", description: "Green Tea", temperature: 100, brew_time: 5)
      t3 = Tea.create(title: "Mint", description: "Mint Tea", temperature: 103, brew_time: 8)
      t4 = Tea.create(title: "Matcha", description: "Matcha Tea", temperature: 107, brew_time: 9)

      Subscription.create(title: t1.title, price: 10.00, status: 0, frequency: 1, tea_id: t1.id, customer_id: c1.id)
      Subscription.create(title: t2.title, price: 10.00, status: 0, frequency: 1, tea_id: t2.id, customer_id: c1.id)
      Subscription.create(title: t3.title, price: 10.00, status: 1, frequency: 1, tea_id: t3.id, customer_id: c1.id)

      get "/api/v1/customers/#{c1.id}/subscriptions"
      result = JSON.parse(response.body, symbolize_names: true)

      expect(response).to be_successful

      expect(result).to be_a Hash

      expect(result).to have_key(:data)
      expect(result[:data]).to be_an Array
      expect(result[:data].count).to eq(3)

      result[:data].each do |subscription|
        expect(subscription).to have_key(:id)
        expect(subscription).to have_key(:type)
        expect(subscription[:type]).to eq("subscription")
        expect(subscription).to have_key(:attributes)
        expect(subscription[:attributes]).to have_key(:id)
        expect(subscription[:attributes]).to have_key(:title)
        expect(subscription[:attributes]).to have_key(:price)
        expect(subscription[:attributes]).to have_key(:status)
        expect(subscription[:attributes]).to have_key(:frequency)
      end
    end

    it 'will return only the active subscriptions when the param is set to true' do
      c1 = Customer.create(first_name: "Test", last_name: "Person1", email: "test@person1.com", address: "12345 Something Road")

      t1 = Tea.create(title: "Earl Grey", description: "Black Tea", temperature: 110, brew_time: 3)
      t2 = Tea.create(title: "Green", description: "Green Tea", temperature: 100, brew_time: 5)
      t3 = Tea.create(title: "Mint", description: "Mint Tea", temperature: 103, brew_time: 8)
      t4 = Tea.create(title: "Matcha", description: "Matcha Tea", temperature: 107, brew_time: 9)

      Subscription.create(title: t1.title, price: 10.00, status: 0, frequency: 1, tea_id: t1.id, customer_id: c1.id)
      Subscription.create(title: t2.title, price: 10.00, status: 0, frequency: 1, tea_id: t2.id, customer_id: c1.id)
      Subscription.create(title: t3.title, price: 10.00, status: 1, frequency: 1, tea_id: t3.id, customer_id: c1.id)

      get "/api/v1/customers/#{c1.id}/subscriptions", params: { status: "active" }
      result = JSON.parse(response.body, symbolize_names: true)
      expect(response).to be_successful

      expect(result).to be_a Hash

      expect(result).to have_key(:data)
      expect(result[:data]).to be_an Array
      expect(result[:data].count).to eq(2)

      result[:data].each do |subscription|
        expect(subscription).to have_key(:id)
        expect(subscription).to have_key(:type)
        expect(subscription[:type]).to eq("subscription")
        expect(subscription).to have_key(:attributes)
        expect(subscription[:attributes]).to have_key(:id)
        expect(subscription[:attributes]).to have_key(:title)
        expect(subscription[:attributes]).to have_key(:price)
        expect(subscription[:attributes]).to have_key(:status)
        expect(subscription[:attributes]).to have_key(:frequency)
      end
    end

    it 'will only return cancelled subscriptions when the param is set to false' do
      c1 = Customer.create(first_name: "Test", last_name: "Person1", email: "test@person1.com", address: "12345 Something Road")

      t1 = Tea.create(title: "Earl Grey", description: "Black Tea", temperature: 110, brew_time: 3)
      t2 = Tea.create(title: "Green", description: "Green Tea", temperature: 100, brew_time: 5)
      t3 = Tea.create(title: "Mint", description: "Mint Tea", temperature: 103, brew_time: 8)
      t4 = Tea.create(title: "Matcha", description: "Matcha Tea", temperature: 107, brew_time: 9)

      Subscription.create(title: t1.title, price: 10.00, status: 0, frequency: 1, tea_id: t1.id, customer_id: c1.id)
      Subscription.create(title: t2.title, price: 10.00, status: 0, frequency: 1, tea_id: t2.id, customer_id: c1.id)
      Subscription.create(title: t3.title, price: 10.00, status: 1, frequency: 1, tea_id: t3.id, customer_id: c1.id)

      get "/api/v1/customers/#{c1.id}/subscriptions", params: { status: "cancelled" }
      result = JSON.parse(response.body, symbolize_names: true)

      expect(result).to be_a Hash

      expect(result).to have_key(:data)
      expect(result[:data]).to be_an Array
      expect(result[:data].count).to eq(1)

      result[:data].each do |subscription|
        expect(subscription).to have_key(:id)
        expect(subscription).to have_key(:type)
        expect(subscription[:type]).to eq("subscription")
        expect(subscription).to have_key(:attributes)
        expect(subscription[:attributes]).to have_key(:id)
        expect(subscription[:attributes]).to have_key(:title)
        expect(subscription[:attributes]).to have_key(:price)
        expect(subscription[:attributes]).to have_key(:status)
        expect(subscription[:attributes]).to have_key(:frequency)
      end
    end
  end
end
