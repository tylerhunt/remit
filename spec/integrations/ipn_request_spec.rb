require File.dirname(__FILE__) + '/integrations_helper'

describe 'an IPN request' do
  before(:each) do
    @request_params = {
      "expiry"            => "10/2013",
      "tokenID"           => "Q5IG5ETFCEBU8KBLTI4JHINQVL6VAJVHICBRR49AKLPIEZH1KB1S8C7VHAJJMLJ3",
      "status"            => "SC",
      "callerReference"   => "1253247023946cMcrTRrjtLjNrZGNKchWfDtUEIGuJfiOBAAJYPjbytBV",
      "signatureMethod"   => "RSA-SHA1",
      "signatureVersion"  => "2",
      "certificateUrl"    => "https://fps.amazonaws.com/certs/090909/PKICert.pem",
      "controller"        => "amazon_fps", # controller and action get deleted
      "action"            => "index",
      "signature"         => "H4NTAsp3YwAEiyQ86j5B53lksv2hwwEaEFxtdWFpy9xX764AZy/Dm0RLEykUUyPVLgqCOlMopay5" \
                           + "Qxr/VDwhdYAzgQzA8VCV8x9Mn0caKsJT2HCU6tSLNa6bLwzg/ildCm2lHDho1Xt2yaBHMt+/Cn4q" \
                           + "I5B+6PDrb8csuAWxW/mbUhk7AzazZMfQciJNjS5k+INlcvOOtQqoA/gVeBLsXK5jNsTh09cNa7pb" \
                           + "gAvey+0DEjYnIRX+beJV6EMCPZxnXDGo0fA1PENLWXIHtAoIJAfLYEkVbT2lva2tZ0KBBWENnSjf" \
                           + "26lMZVokypIo4huoGaZMp1IVkImFi3qC6ipCrw=="
    }
    @request = Remit::IpnRequest.new(@request_params, 'http://www.mysite.com/call_pay.jsp', ACCESS_KEY, SECRET_KEY)
  end

  it 'should be a valid request' do
    @request.should be_valid
  end

  it 'should pass through access to given parameters' do
    @request.status.should == 'SC'
    @request.callerReference.should == '1253247023946cMcrTRrjtLjNrZGNKchWfDtUEIGuJfiOBAAJYPjbytBV'
  end
end
