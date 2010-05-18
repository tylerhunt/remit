require File.dirname(__FILE__) + '/units_helper'

describe 'an IPN request' do
#This needs to be updated to match the new Verify methods

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
#      "signature"         => "DA7ZbuQaBDt2/+Mty9XweJyqI1E=",
#      "status"            => "SUCCESS",
#      "transactionAmount" => "USD 3.50",
#      "transactionDate"   => "1224687134",
#      "transactionId"     => "13KIGL9RC25853BGPPOS2VSKBKF2JERR3HO"
#    }
#    sandbox = true
#    api = Remit::API.new('FPS_ACCESS_KEY', 'FPS_SECRET_KEY', sandbox )
#    
#    @request = Remit::IpnRequest.new(@request_params, 'THISISMYTESTKEY',api,'http://yourhost.com/ipn/processor','')
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
end
