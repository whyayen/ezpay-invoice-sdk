module EzpayInvoice
  module Api
    module Payloads
      class InvoiceIssue < Base
        include EzpayInvoice::Api::Properties::Item

        property(:Version, from: :version, default: '1.4')
        property(:TransNum, from: :trans_num)
        property(:MerchantOrderNo, from: :merchant_order_no, required: true)
        property(:Status, from: :status, required: true)
        property(:CreateStatusTime, from: :create_status_time)
        property(:Category, from: :category, required: true)
        property(:BuyerName, from: :buyer_name, required: true)
        property(:BuyerUBN, from: :buyer_ubn)
        property(:BuyerAddress, from: :buyer_address)
        property(:BuyerEmail, from: :buyer_email)
        property(:CarrierType, from: :carrier_type)
        property(:CarrierNum, from: :carrier_num)
        property(:LoveCode, from: :love_code)
        property(:PrintFlag, from: :print_flag, required: true)
        property(:KioskPrintFlag, from: :kiosk_print_flag)
        property(:TaxType, from: :tax_type, required: true)
        property(:TaxRate, from: :tax_rate, required: true)
        property(:CustomsClearance, from: :customs_clearance)
        property(:Amt, from: :amt, required: true)
        property(:AmtSales, from: :amt_sales)
        property(:AmtZero, from: :amt_zero)
        property(:AmtFree, from: :amt_free)
        property(:TaxAmt, from: :tax_amt, required: true)
        property(:TotalAmt, from: :total_amt, required: true)
        property(
          :ItemTaxType,
          from: :item_tax_type,
          with: ->(value) { value.join('|') },
        )
        property(:Comment, from: :comment)
      end
    end
  end
end