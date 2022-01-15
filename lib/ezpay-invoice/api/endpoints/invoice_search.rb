module EzpayInvoice
  module Api
    module Endpoints
      module InvoiceSearch
        def invoice_search(payload = {})
          post(
            'invoice_search',
            EzpayInvoice::Api::Payloads::InvoiceSearch.new(payload)
          )
        end
      end
    end
  end
end