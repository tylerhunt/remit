#require File.dirname(__FILE__) + '/integrations_helper'
#
#describe 'an IPN request' do
# This needs to be updated to match the new Verify methods
# The signature does not match the one calculated for these req params by amazon.  Need to get a fresh example.
#  before(:each) do
#    @request_params = {
#      "action"            => "notice",
#      "buyerName"         => "Fps Buyer",
#      "callerReference"   => "4-8-1-3.5",
#      "controller"        => "amazon_fps/ipn",
#      "operation"         => "PAY",
#      "paymentMethod"     => "CC",
#      "recipientEmail"    => "recipient@email.url",
#      "recipientName"     => "Fps Business",
#      "signatureVersion"  => Remit::API::SIGNATURE_VERSION,
#      "signatureMethod"   => "RSA-SHA1",
#      "certificateUrl"    => "https://fps.sandbox.amazonaws.com/certs/090909/PKICert.pem",
#      Remit::IpnRequest::SIGNATURE_KEY => "DA7ZbuQaBDt2/+Mty9XweJyqI1E=",
#      "status"            => "SUCCESS",
#      "transactionAmount" => "USD 3.50",
#      "transactionDate"   => "1224687134",
#      "transactionId"     => "13KIGL9RC25853BGPPOS2VSKBKF2JERR3HO"
#    }
#
#    @request = Remit::IpnRequest.new('http://yourhost.com/ipn/processor', @request_params, remit)
#  end
#
#  it 'should be a valid request' do
#    @request.should be_valid
#  end
#
#  it 'should pass through access to given parameters' do
#    @request.status.should == 'SUCCESS'
#    @request.operation.should == 'PAY'
#    @request.transactionId.should == '13KIGL9RC25853BGPPOS2VSKBKF2JERR3HO'
#  end
#end
