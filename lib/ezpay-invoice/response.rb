require 'active_support/core_ext/hash/keys'
require 'active_support/core_ext/string/inflections'

module EzpayInvoice
  class Response
    attr_reader :body, :status, :message, :result

    def initialize(rest_response)
      response_hash = JSON.parse(rest_response.body)
      response_hash.deep_transform_keys! { |k| k.to_s.underscore }

      @body = response_hash
      @status = response_hash['status']
      @message = response_hash['message']
      @result = response_hash['result']

      raise EzpayResponseError.new(@message, @status) if @status != 'SUCCESS'
    end
  end
end