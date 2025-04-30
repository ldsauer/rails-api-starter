# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end



TeaSubscription.destroy_all
Subscription.destroy_all
Customer.destroy_all
Tea.destroy_all

logan = Customer.create!(first_name: "Logan", last_name: "Flower", email: "logan@example.com", address: "123 Tea Ln")
laurel = Customer.create!(first_name: "Laurel", last_name: "Bloom", email: "laurel@example.com", address: "456 Infuser Ave")
josh = Customer.create!(first_name: "Josh", last_name: "Steep", email: "josh@example.com", address: "789 Kettle Ct")

black_teas = [
  Tea.create!(title: "Earl Grey", description: "Bold black tea with bergamot", temperature: "95C", brew_time: "4 min"),
  Tea.create!(title: "Assam", description: "Malty and robust", temperature: "100C", brew_time: "5 min")
]

green_teas = [
  Tea.create!(title: "Sencha", description: "Japanese steamed green tea", temperature: "80C", brew_time: "2 min"),
  Tea.create!(title: "Matcha", description: "Stone-ground green tea powder", temperature: "75C", brew_time: "1 min")
]

white_teas = [
  Tea.create!(title: "Silver Needle", description: "Delicate floral white tea", temperature: "80C", brew_time: "3 min"),
  Tea.create!(title: "White Peony", description: "Smooth and mellow", temperature: "85C", brew_time: "4 min")
]

herbal_teas = [
  Tea.create!(title: "Chamomile", description: "Relaxing bedtime blend", temperature: "90C", brew_time: "5 min"),
  Tea.create!(title: "Peppermint", description: "Cooling and refreshing", temperature: "95C", brew_time: "6 min")
]

black_sub = Subscription.create!(
  title: "Black Tea Subscription",
  price: 12.99,
  status: "active",
  frequency: "monthly",
  customer: logan
)

green_sub = Subscription.create!(
  title: "Green Tea Subscription",
  price: 10.99,
  status: "active",
  frequency: "bi-weekly",
  customer: laurel
)

white_sub = Subscription.create!(
  title: "White Tea Subscription",
  price: 11.49,
  status: "cancelled",
  frequency: "monthly",
  customer: josh
)

herbal_sub = Subscription.create!(
  title: "Herbal Tea Subscription",
  price: 9.99,
  status: "active",
  frequency: "weekly",
  customer: logan
)

green_sub.update!(customer: laurel)
white_sub.update!(customer: logan)

black_teas.each { |tea| TeaSubscription.create!(subscription: black_sub, tea: tea) }
green_teas.each { |tea| TeaSubscription.create!(subscription: green_sub, tea: tea) }
white_teas.each { |tea| TeaSubscription.create!(subscription: white_sub, tea: tea) }
herbal_teas.each { |tea| TeaSubscription.create!(subscription: herbal_sub, tea: tea) }

