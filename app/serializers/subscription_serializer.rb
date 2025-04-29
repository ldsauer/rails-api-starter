class SubscriptionSerializer
  include JSONAPI::Serializer
  attributes :title, :price, :status, :frequency

  belongs_to :customer
  has_many :teas, through: :tea_subscriptions
end
