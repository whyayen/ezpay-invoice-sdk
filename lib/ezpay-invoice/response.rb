require 'digest'
require 'active_support/core_ext/hash/keys'
require 'active_support/core_ext/string/inflections'

module EzpayInvoice
  class Response
    attr_reader :body, :status, :message, :result

    def initialize(rest_response)
      response_hash = JSON.parse(rest_response.body)
      raise EzpayResponseError.new(
        response_hash['Message'],
        response_hash['Status']
      ) if response_hash['Status'] != 'SUCCESS'

      @body = response_hash
      @status = response_hash['Status']
      @message = response_hash['Message']
      @result = JSON.parse(response_hash['Result']).deep_transform_keys { |k| k.to_s.underscore }
    end
  end
end