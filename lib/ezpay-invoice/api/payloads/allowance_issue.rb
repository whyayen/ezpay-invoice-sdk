module EzpayInvoice
  module Api
    module Payloads
      class AllowanceIssue < Base
        include EzpayInvoice::Api::Properties::Item

        property(:Version, from: :version, default: '1.3')
        property(:InvoiceNo, from: :invoice_no, required: true)
        property(:MerchantOrderNo, from: :merchant_order_no, required: true)
        property(:TaxTypeForMixed, from: :tax_type_for_mixed)
        property(
          :ItemTaxAmt,
          from: :item_tax_amt,
          with: ->(value) { value.join('|') },
          required: true
        )
        property(:TotalAmt, from: :total_amt, required: true)
        property(:BuyerEmail, from: :buyer_email)
        property(:Status, from: :status, required: true)
      end
    end
  end
end