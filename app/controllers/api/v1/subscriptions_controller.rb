class Api::V1::SubscriptionsController < ApplicationController
  def index
    subscriptions = Subscription.all
    render json: SubscriptionSerializer.new(subscriptions, { include: [:customer, :teas] })
  end

  def show
    subscription = Subscription.find(params[:id])
    render json: SubscriptionSerializer.new(subscription,  { include: [:customer, :teas] })

  rescue ActiveRecord::RecordNotFound
    render json: ErrorSerializer.format_error("Subscription not found", 404), status: :not_found
  end

  def cancel
    subscription = Subscription.find(params[:id])
    subscription.update(status: "cancelled")
    render json: SubscriptionSerializer.new(subscription,  { include: [:customer, :teas] })

  rescue ActiveRecord::RecordNotFound 
    render json: ErrorSerializer.format_error("Subscription not found", 404), status: :not_found
  end
end
