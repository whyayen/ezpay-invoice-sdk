module EzpayInvoice
  module Api
    module Properties
      module Item
        def self.included(base)
          base.class_eval do
            property(
              :ItemName,
              from: :item_name,
              with: ->(value) { value.join('|') },
              required: true
            )
            property(
              :ItemCount,
              from: :item_count,
              with: ->(value) { value.join('|') },
              required: true
            )
            property(
              :ItemUnit,
              from: :item_unit,
              with: ->(value) { value.join('|') },
              required: true
            )
            property(
              :ItemPrice,
              from: :item_price,
              with: ->(value) { value.join('|') },
              required: true
            )
            property(
              :ItemAmt,
              from: :item_amt,
              with: ->(value) { value.join('|') },
              required: true
            )
          end
        end
      end
    end
  end
end