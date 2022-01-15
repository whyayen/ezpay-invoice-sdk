module EzpayInvoice
  module Api
    module Properties
      module General
        def self.included(base)
          base.class_eval do
            property :RespondType, from: :respond_type, default: 'JSON'
            property :TimeStamp, from: :timestamp, default: Time.now.to_i
          end
        end
      end
    end
  end
end