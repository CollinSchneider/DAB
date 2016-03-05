Rails.configuration.stripe = {
  :publishable_key => 'pk_test_BnTh2K2CSof6rh1MFjqlMFla',
  :secret_key      => 'sk_test_uQFhbzVPXCNfYt8RWMeCHZTl'
}

Stripe.api_key = Rails.configuration.stripe[:secret_key]