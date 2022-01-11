module EzpayInvoice
  module Configurable
    attr_accessor :merchant_id, :hash_key, :hash_iv

    MODES = ['dev', 'prod']

    def mode
      @mode || 'dev'
    end

    def mode=(_mode)
      raise ArgumentError, "mode must be one of [#{MODES.join(', ')}]." if !MODES.include?(_mode)
      @mode = _mode
    end

    def setup
      block_given? ? yield(self) : self
    end

    def config
      self
    end

    class << self
      def attributes
        @attributes ||= [
          :merchant_id,
          :hash_key,
          :hash_iv,
          :mode
        ]
      end
    end
  end
end