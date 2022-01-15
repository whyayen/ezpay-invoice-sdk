module EzpayInvoice
  class Error < StandardError; end
  class CheckCodeInvalid < Error; end

  class EzpayResponseError < StandardError
    attr_reader :status

    def initialize(message, status)
      super(message)
      @status = status
    end
  end
end