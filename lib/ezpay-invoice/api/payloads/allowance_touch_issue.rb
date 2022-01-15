module EzpayInvoice
  module Api
    module Payloads
      class AllowanceTouchIssue < Base
        property(:Version, from: :version, default: '1.0')
        property(:AllowanceStatus, from: :allowance_status, required: true)
        property(:AllowanceNo, from: :allowance_no, required: true)
        property(:MerchantOrderNo, from: :merchant_order_no, required: true)
        property(:TotalAmt, from: :total_amt, required: true)
      end
    end
  end
end