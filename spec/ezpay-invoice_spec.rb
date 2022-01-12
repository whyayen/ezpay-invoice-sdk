RSpec.describe EzpayInvoice do
  describe 'setup' do
    it 'sets merchant_id' do
      EzpayInvoice.setup do |config|
        config.merchant_id = 'fake_merchant_id'
      end

      expect(EzpayInvoice.merchant_id).to eq('fake_merchant_id')
    end

    it 'reads config' do
      test_key = 'fake_hash_key'
      EzpayInvoice.setup do |config|
        config.hash_key = test_key
      end

      expect(EzpayInvoice.hash_key).to eq(test_key)
      expect(EzpayInvoice.config.hash_key).to eq(test_key)
    end
  end
end
