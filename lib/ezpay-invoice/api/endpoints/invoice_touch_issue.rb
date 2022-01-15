module EzpayInvoice
  module Api
    module Endpoints
      module InvoiceTouchIssue
        def invoice_touch_issue(payload = {})
          post(
            'invoice_touch_issue',
            EzpayInvoice::Api::Payloads::InvoiceTouchIssue.new(payload)
          )
        end
      end
    end
  end
end