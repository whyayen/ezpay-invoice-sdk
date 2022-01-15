require 'rest-client'
require 'addressable/uri'
require 'json'

require_relative 'response'

module EzpayInvoice
  module Request
    def post(path, data)
      uri = Addressable::URI.new
      uri.query_values = data
      payload = {
        'MerchantID_' => @merchant_id,
        'PostData_' => encrypt(uri.query)
      }
      request(:post, path, payload)
    end

    private
    def api_endpoint
      subdomain = @mode == 'prod' ? 'inv' : 'cinv'
      "https://#{subdomain}.ezpay.com.tw/Api/"
    end

    def request(method, path, payload)
      response = RestClient::Request.execute(
        method: method,
        url: Addressable::URI.parse("#{api_endpoint}#{path}").normalize.to_str,
        payload: payload
      )

      Response.new(response)
    end

    def encrypt(data)
      aes = OpenSSL::Cipher.new('AES-256-CBC')
      aes.encrypt
      aes.key = @hash_key
      aes.iv = @hash_iv
      (aes.update(data) + aes.final).unpack("H*").first.upcase
    end
  end
end