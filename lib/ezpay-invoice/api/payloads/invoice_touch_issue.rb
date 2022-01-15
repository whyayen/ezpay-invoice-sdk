module EzpayInvoice
  module Api
    module Payloads
      class InvoiceTouchIssue < Base
        property(:Version, from: :version, default: '1.0')
        property(:TransNum, from: :trans_num)
        property(:MerchantOrderNo, from: :merchant_order_no, required: true)
        property(:InvoiceTransNo, from: :invoice_trans_no, required: true)
        property(:TotalAmt, from: :total_amt, required: true)
      end
    end
  end
end