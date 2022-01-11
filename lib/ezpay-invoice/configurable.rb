module EzpayInvoice
  module Configurable
    extend self

    attr_accessor :merchant_id, :hash_key, :hash_iv

    MODES = ['dev', 'prod']

    def mode
      @mode || 'dev'
    end

    def mode=(_mode)
      raise ArgumentError, "mode must be one of [#{MODES.join(', ')}]." if !MODES.include?(_mode)
      @mode = _mode
    end
  end

  class << self
    def setup
      block_given? ? yield(Configurable) : Configurable
    end

    def config
      Configurable
    end
  end
end