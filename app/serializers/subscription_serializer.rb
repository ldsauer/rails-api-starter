class SubscriptionSerializer
  include JSONAPI::Serializer
  attributes :title, :price, :status, :frequency

  attribute :customer_name do |sub|
    "#{sub.customer.first_name} #{sub.customer.last_name}"
  end

  belongs_to :customer
  has_many :teas, through: :tea_subscriptions
end
