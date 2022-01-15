module EzpayInvoice
  module Api
    module Endpoints
      module AllowanceInvalid
        def allowance_invalid(payload = {})
          post(
            'allowanceInvalid',
            EzpayInvoice::Api::Payloads::AllowanceInvalid.new(payload)
          )
        end
      end
    end
  end
end