require 'hashie'

module EzpayInvoice
  module Api
    module Payloads
      class Base < Hashie::Dash
        include Hashie::Extensions::IgnoreUndeclared
        include Hashie::Extensions::Dash::PropertyTranslation
        include EzpayInvoice::Api::Properties::General
      end
    end
  end
end