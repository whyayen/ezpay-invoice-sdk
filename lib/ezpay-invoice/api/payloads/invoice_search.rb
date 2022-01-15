module EzpayInvoice
  module Api
    module Payloads
      class InvoiceSearch < Base
        property(:Version, from: :version, default: '1.3')
        property(:SearchType, from: :search_type)
        property(:MerchantOrderNo, from: :merchant_order_no, required: true)
        property(:TotalAmt, from: :total_amt, required: true)
        property(:InvoiceNumber, from: :invoice_number, required: true)
        property(:RandomNum, from: :random_num, required: true)
        property(:DisplayFlag, from: :display_flag)
      end
    end
  end
end