# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end


customer = Customer.create!(
  first_name: "Logan",
  last_name: "Sauer",
  email: "tealover2@gmail.com",
  address: "123 Tea Lane"
)

subscription = Subscription.create!(
  title: "Herbal Box",
  price: 10.99,
  status: "active",
  frequency: "monthly",
  customer: customer
)

tea = Tea.create!(
  title: "Chamomile Calm",
  description: "A calming herbal blend",
  temperature: "95C",
  brew_time: "5 minutes"
)

TeaSubscription.create!(
  subscription: subscription,
  tea: tea
)