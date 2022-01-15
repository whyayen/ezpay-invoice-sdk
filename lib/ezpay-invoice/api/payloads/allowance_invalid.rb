module EzpayInvoice
  module Api
    module Payloads
      class AllowanceInvalid < Base
        property(:Version, from: :version, default: '1.0')
        property(:AllowanceNo, from: :allowance_no, required: true)
        property(:InvalidReason, from: :invalid_reason, required: true)
      end
    end
  end
end