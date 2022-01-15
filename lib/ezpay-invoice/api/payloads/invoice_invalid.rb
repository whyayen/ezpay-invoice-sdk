module EzpayInvoice
  module Api
    module Payloads
      class InvoiceInvalid < Base
        property(:Version, from: :version, default: '1.0')
        property(:InvoiceNumber, from: :invoice_number, required: true)
        property(:InvalidReason, from: :invalid_reason, required: true)
      end
    end
  end
end