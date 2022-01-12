require_relative 'ezpay-invoice/version'
require_relative 'ezpay-invoice/configurable'
require_relative 'ezpay-invoice/client'

module EzpayInvoice
  class << self
    include EzpayInvoice::Configurable
  end

  class Error < StandardError; end
end
