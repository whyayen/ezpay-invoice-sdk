require_relative 'request'
require_relative 'api/properties'
require_relative 'api/payloads'
require_relative 'api/endpoints/invoice_issue'
require_relative 'api/endpoints/invoice_touch_issue'
require_relative 'api/endpoints/invoice_invalid'
require_relative 'api/endpoints/invoice_search'
require_relative 'api/endpoints/allowance_issue'
require_relative 'api/endpoints/allowance_touch_issue'
require_relative 'api/endpoints/allowance_invalid'

module EzpayInvoice
  class Client
    include EzpayInvoice::Configurable
    include EzpayInvoice::Request
    include EzpayInvoice::Api::Endpoints::InvoiceIssue
    include EzpayInvoice::Api::Endpoints::InvoiceTouchIssue
    include EzpayInvoice::Api::Endpoints::InvoiceInvalid
    include EzpayInvoice::Api::Endpoints::InvoiceSearch
    include EzpayInvoice::Api::Endpoints::AllowanceIssue
    include EzpayInvoice::Api::Endpoints::AllowanceTouchIssue
    include EzpayInvoice::Api::Endpoints::AllowanceInvalid

    def initialize(options = {})
      EzpayInvoice::Configurable.attributes.each do |key|
        value = options.key?(key) ? options[key] : EzpayInvoice.send(key)
        instance_variable_set(:"@#{key}", value)
      end
    end
  end
end
