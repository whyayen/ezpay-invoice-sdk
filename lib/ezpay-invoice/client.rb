module EzpayInvoice
  class Client
    include EzpayInvoice::Configurable

    def initialize(options = {})
      EzpayInvoice::Configurable.attributes.each do |key|
        value = options.key?(key) ? options[key] : EzpayInvoice.send(key)
        instance_variable_set(:"@#{key}", value)
      end
    end
  end
end
