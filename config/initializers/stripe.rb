Rails.configuration.stripe = {
  :publishable_key => ENV['STRIPE_PUBLIC_TOKEN'],
  :secret_key      => ENV['STRIPE_SECRET_TOKEN']
}

Stripe.api_key = Rails.configuration.stripe[:secret_key]
