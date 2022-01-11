require_relative "ezpay-invoice/version"
require_relative "ezpay-invoice/configurable"

module EzpayInvoice
  include EzpayInvoice::Configurable

  class Error < StandardError; end
end
