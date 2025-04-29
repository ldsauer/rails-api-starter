require 'rails_helper'

RSpec.describe "Api::V1::Subscriptions", type: :request do
  describe "GET /api/v1/subscriptions" do
    before(:each) do 
      @customer = Customer.create!(
        first_name: "Logan", 
        last_name: "Sauer", 
        email: "tealover2@gmail.com", 
        address: "123 Tea Lane"
        )
      @subscription = Subscription.create!(
        title: "Herbal Box", 
        price: 10.99,
        status: "active", 
        frequency: "monthly", 
        customer: @customer
      )
      @tea = Tea.create!(
        title: "rooibos", 
        description: "sweet and slightly nutty",
        temperature: "208F",
        brew_time: "6 mins"
      )
      @tea_subscription = TeaSubscription.create!(subscription: @subscription, tea: @tea)
    end

    it "returns all subscriptions" do 
      get "/api/v1/subscriptions"

      expect(response).to be_successful

      json = JSON.parse(response.body, symbolize_names: true)

      expect(json).to have_key(:data)
      expect(json[:data]).to be_an(Array)

      subscription = json[:data].first

      expect(subscription).to have_key(:id)
      expect(subscription[:id]).to eq(@subscription.id.to_s)
      expect(subscription).to have_key(:type)
      expect(subscription[:type]).to eq("subscription")
      expect(subscription).to have_key(:attributes)

      attributes = subscription[:attributes]

      expect(attributes[:title]).to eq("Herbal Box")
      expect(attributes[:price]).to eq("10.99")
      expect(attributes[:status]).to eq("active")
      expect(attributes[:frequency]).to eq("monthly")
    end

    it "returns specific subscriptions" do 
      get "/api/v1/subscriptions/#{@subscription.id}" 

      expect(response).to be_successful

      json = JSON.parse(response.body, symbolize_names: true)

      expect(json).to have_key(:data)
      expect(json[:data]).to be_a(Hash)

      subscription = json[:data]

      expect(subscription).to have_key(:id)
      expect(subscription[:id]).to eq(@subscription.id.to_s)
      expect(subscription).to have_key(:type)
      expect(subscription[:type]).to eq("subscription")
      expect(subscription).to have_key(:relationships)
      expect(subscription[:relationships]).to have_key(:customer)
      expect(subscription[:relationships]).to have_key(:teas)
      expect(subscription).to have_key(:attributes)

      attributes = subscription[:attributes]

      expect(attributes[:title]).to eq("Herbal Box")
      expect(attributes[:price]).to eq("10.99")
      expect(attributes[:status]).to eq("active")
      expect(attributes[:frequency]).to eq("monthly")

      customer_data = subscription[:relationships][:customer][:data]

      expect(customer_data[:id]).to eq(@customer.id.to_s)
      expect(customer_data[:type]).to eq("customer")
    end

    it "returns an error when the ID does not exist" do 
      get "/api/v1/subscriptions/22222222222"

      expect(response).to have_http_status(:not_found)

      json = JSON.parse(response.body, symbolize_names: true)

      expect(json[:errors].first[:detail]).to eq("Subscription not found")
    end

    it "can cancel a subscription" do 
      patch "/api/v1/subscriptions/#{@subscription.id}/cancel"

      expect(response).to be_successful

      json = JSON.parse(response.body, symbolize_names: true)

      expect(json).to have_key(:data)
      expect(json[:data]).to be_a(Hash)

      subscription = json[:data]

      expect(subscription).to have_key(:id)
      expect(subscription[:id]).to eq(@subscription.id.to_s)
      expect(subscription).to have_key(:type)
      expect(subscription).to have_key(:relationships)
      expect(subscription[:relationships]).to have_key(:customer)
      expect(subscription[:relationships]).to have_key(:teas)
      expect(subscription[:type]).to eq("subscription")
      expect(subscription).to have_key(:attributes)

      attributes = subscription[:attributes]

      expect(attributes[:title]).to eq("Herbal Box")
      expect(attributes[:price]).to eq("10.99")
      expect(attributes[:status]).to eq("cancelled")
      expect(attributes[:frequency]).to eq("monthly")

      customer_data = subscription[:relationships][:customer][:data]

      expect(customer_data[:id]).to eq(@customer.id.to_s)
      expect(customer_data[:type]).to eq("customer")

      @subscription.reload
      expect(@subscription.status).to eq("cancelled")
    end

    it "returns an error when the ID does not exist for a patch" do 
      patch "/api/v1/subscriptions/22222222222/cancel"

      expect(response).to have_http_status(:not_found)

      json = JSON.parse(response.body, symbolize_names: true)

      expect(json[:errors].first[:detail]).to eq("Subscription not found")
    end
  end
end
