require 'rest-client'
require 'addressable/uri'
require 'json'

module EzpayInvoice
  module Request
    def post(path, data)
      request(:post, path, data)
    end

    private
    def api_endpoint
      subdomain = @mode == 'prod' ? 'inv' : 'cinv'
      "https://#{subdomain}.ezpay.com.tw/Api/"
    end

    def request(method, path, data)
      payload = {
        MerchantID_: @merchant_id,
        PostData_: encrypt(data.to_json)
      }

      response = RestClient::Request.execute(
        method: method,
        url: Addressable::URI.parse("#{api_endpoint}#{path}").normalize.to_str,
        data: payload
      )
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