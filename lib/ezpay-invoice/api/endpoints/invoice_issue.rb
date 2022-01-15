module EzpayInvoice
  module Api
    module Endpoints
      module InvoiceIssue
        def invoice_issue(payload = {})
          post(
            'invoice_issue',
            EzpayInvoice::Api::Payloads::InvoiceIssue.new(payload)
          )
        end
      end
    end
  end
end