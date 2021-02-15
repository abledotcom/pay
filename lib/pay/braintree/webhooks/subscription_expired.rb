# A subscription reaches the specified number of billing cycles and expires.

module Pay
  module Braintree
    module Webhooks
      class SubscriptionExpired
        def call(event)
          subscription = event.subscription
          return if subscription.nil?

          pay_subscription = Pay.subscription_model.find_by(processor: :braintree, processor_id: subscription.id)
          return unless pay_subscription.present?

          pay_subscription.update!(ends_at: Time.current, status: :canceled)
        end
      end
    end
  end
end
