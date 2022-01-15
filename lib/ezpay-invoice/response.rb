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
      @result = transform_keys(JSON.parse(response_hash['Result']))
      parse_item_detail
    end

    private
    def parse_item_detail
      if @result.has_key?('item_detail')
        item_detail = JSON.parse(@result['item_detail']).map { |item| transform_keys(item) }
        @result['item_detail'] = item_detail
      end
    end

    def transform_keys(hash)
      hash.deep_transform_keys do |k|
        k.to_s.underscore
      end
    end
  end
end