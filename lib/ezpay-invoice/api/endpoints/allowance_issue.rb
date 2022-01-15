module EzpayInvoice
  module Api
    module Endpoints
      module AllowanceIssue
        def allowance_issue(payload = {})
          post(
            'allowance_issue',
            EzpayInvoice::Api::Payloads::AllowanceIssue.new(payload)
          )
        end
      end
    end
  end
end