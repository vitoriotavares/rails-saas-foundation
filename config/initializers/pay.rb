# Only configure Pay if it's not already configured
return if defined?(@pay_configured)

Pay.setup do |config|
  # For use in the notification email that gets sent on successful payments
  # You'll want to replace this with your actual product name
  config.application_name = "SaaS Foundation"

  # Business information for receipts
  config.business_name = "Your Business Name"
  config.business_address = "Your Business Address"

  # Auto-capture charges immediately
  config.default_product_name = "SaaS Foundation"
  config.default_plan_name = "SaaS Foundation"

  # Braintree Marketplace ID
  # config.braintree_marketplace_id = nil

  # Stripe Marketplace ID
  # config.stripe_marketplace_id = nil

  # Callback when a payment has been successfully completed
  # config.on_payment_success = Proc.new {|payment| WebhookJob.perform_later("payment.success", payment) }

  # Callback when a payment has failed
  # config.on_payment_failure = Proc.new {|payment| WebhookJob.perform_later("payment.failure", payment) }

  # Callback when a subscription has been successfully created
  # config.on_subscription_create = Proc.new {|subscription| WebhookJob.perform_later("subscription.create", subscription) }

  # Callback when a subscription has been updated
  # config.on_subscription_update = Proc.new {|subscription| WebhookJob.perform_later("subscription.update", subscription) }

  # Callback when a subscription has been cancelled
  # config.on_subscription_destroy = Proc.new {|subscription| WebhookJob.perform_later("subscription.cancel", subscription) }

  # Callback when a customer has been successfully created
  # config.on_customer_create = Proc.new {|customer| WebhookJob.perform_later("customer.create", customer) }

  # Callback when a customer has been successfully updated
  # config.on_customer_update = Proc.new {|customer| WebhookJob.perform_later("customer.update", customer) }

  # Callback when a customer has been deleted
  # config.on_customer_destroy = Proc.new {|customer| WebhookJob.perform_later("customer.destroy", customer) }
end

@pay_configured = true