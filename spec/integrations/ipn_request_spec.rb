require File.dirname(__FILE__) + '/integrations_helper'

describe 'an IPN request with a bad signature' do
# This needs to be updated to match the new Verify methods
# The signature does not match the one calculated for these req params by amazon.  Need to get a fresh example.
# So it is currently a test that a bad signature will be verified as BAD
  before(:each) do
    @request_params = {
      "action"            => "notice",
      "buyerName"         => "Fps Buyer",
      "callerReference"   => "4-8-1-3.5",
      "controller"        => "amazon_fps/ipn",
      "operation"         => "PAY",
      "paymentMethod"     => "CC",
      "recipientEmail"    => "recipient@email.url",
      "recipientName"     => "Fps Business",
      "signatureVersion"  => Remit::API::SIGNATURE_VERSION,
      "signatureMethod"   => "RSA-SHA1",
      "certificateUrl"    => "https://fps.sandbox.amazonaws.com/certs/090909/PKICert.pem",
      Remit::IpnRequest::SIGNATURE_KEY => "This-is-a-bad-sig",
      "status"            => "SUCCESS",
      "transactionAmount" => "USD 3.50",
      "transactionDate"   => "1224687134",
      "transactionId"     => "13KIGL9RC25853BGPPOS2VSKBKF2JERR3HO"
    }

    @request = Remit::IpnRequest.new('http://example.com/ipn/processor', @request_params, remit)
  end

  it 'should not be a valid request' do
    @request.should_not be_valid
  end

  it 'should pass through access to given parameters' do
    @request.status.should == 'SUCCESS'
    @request.operation.should == 'PAY'
    @request.transactionId.should == '13KIGL9RC25853BGPPOS2VSKBKF2JERR3HO'
  end
end
