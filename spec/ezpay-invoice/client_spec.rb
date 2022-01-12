RSpec.describe EzpayInvoice::Client do
  describe "#initialize" do
    context "configuration" do
      it "reads global configuration by default" do
        EzpayInvoice.setup { |config| config.merchant_id = 'fake_merchant_id' }
        client = EzpayInvoice::Client.new

        expect(client.merchant_id).to eq('fake_merchant_id')
      end

      it "reads instance configuration if options were set" do
        EzpayInvoice.setup { |config| config.merchant_id = 'global_merchant_id' }
        client = EzpayInvoice::Client.new({merchant_id: 'instance_merchant_id'})

        expect(client.merchant_id).to eq('instance_merchant_id')
      end
    end
  end
end
