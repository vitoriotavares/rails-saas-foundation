class BillingController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user

  def show
    @payment_methods = @user.payment_methods
    @subscriptions = @user.subscriptions
  end

  def checkout
    @plans = [
      {
        name: "Basic",
        price: 999, # $9.99 in cents
        interval: "month",
        stripe_price_id: ENV['STRIPE_BASIC_PRICE_ID'],
        paddle_price_id: ENV['PADDLE_BASIC_PRICE_ID'],
        features: ["10 Projects", "Basic Support", "1GB Storage"]
      },
      {
        name: "Pro",
        price: 1999, # $19.99 in cents
        interval: "month",
        stripe_price_id: ENV['STRIPE_PRO_PRICE_ID'],
        paddle_price_id: ENV['PADDLE_PRO_PRICE_ID'],
        features: ["Unlimited Projects", "Priority Support", "10GB Storage", "Advanced Analytics"]
      }
    ]
  end

  def create_checkout_session
    plan_id = params[:plan_id]
    processor = params[:processor] || 'stripe'
    
    case processor
    when 'stripe'
      create_stripe_checkout_session(plan_id)
    when 'paddle'
      create_paddle_checkout_session(plan_id)
    else
      redirect_to billing_checkout_path(@user), alert: 'Invalid processor selected'
    end
  rescue => e
    Rails.logger.error "Checkout error: #{e.message}"
    redirect_to billing_checkout_path(@user), alert: 'An error occurred while creating checkout session'
  end

  private

  def set_user
    @user = current_user
  end

  def create_stripe_checkout_session(plan_id)
    session = @user.processor(:stripe).checkout(
      mode: "subscription",
      line_items: [{
        price: plan_id,
        quantity: 1
      }],
      success_url: dashboard_url + "?session_id={CHECKOUT_SESSION_ID}",
      cancel_url: billing_checkout_url(@user)
    )
    
    redirect_to session.url, allow_other_host: true
  end

  def create_paddle_checkout_session(plan_id)
    # Paddle implementation would go here
    # For now, redirect to Stripe
    redirect_to billing_checkout_path(@user), alert: 'Paddle integration coming soon!'
  end
end