require 'ezpay-invoice/version'
require 'ezpay-invoice/configurable'
require 'ezpay-invoice/client'

module EzpayInvoice
  class << self
    include EzpayInvoice::Configurable
  end

  class Error < StandardError; end
end
