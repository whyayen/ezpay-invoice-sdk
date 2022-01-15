module EzpayInvoice
  module Api
    module Endpoints
      module InvoiceInvalid
        def invoice_invalid(payload = {})
          post(
            'invoice_invalid',
            EzpayInvoice::Api::Payloads::InvoiceInvalid.new(payload)
          )
        end
      end
    end
  end
end