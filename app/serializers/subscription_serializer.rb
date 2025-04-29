class SubscriptionSerializer
  include JSONAPI::Serializer
  attributes :title, :price, :status, :frequency

  belongs_to :customers 
  has_many :teas, through: :tea_subscriptions
end
