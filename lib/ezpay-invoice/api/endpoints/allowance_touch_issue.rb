module EzpayInvoice
  module Api
    module Endpoints
      module AllowanceTouchIssue
        def allowance_touch_issue(payload = {})
          post(
            'allowance_touch_issue',
            EzpayInvoice::Api::Payloads::AllowanceTouchIssue.new(payload)
          )
        end
      end
    end
  end
end