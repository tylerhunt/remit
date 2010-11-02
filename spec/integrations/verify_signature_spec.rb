require File.dirname(__FILE__) + '/integrations_helper'

describe "VerifySignature API" do

  #Not sure if other KEYS can validate this signature or not. Taken from a test sandbox transaction.
  def correct_params
    {"tokenID"=>"F36RX66AJJF8S3QZ9MP656MAZD2CL3UH5HMIFT75D5ACN6Z9FKCHESAQQXNLVSBM",
     "signatureVersion"=>"2",
     "callerReference"=>"OrderToken-00b6fad394cdef8f95c1dcc72e2bfae06dc09c4f",
     "signature"=>"Jy7oVloTqVl1BKTnFmpiBW0Jpzr3x4E4WoIPxUQMz1vefNO3bhceHTg+zAvB52JcyS2oYmUHltep\n3ifJb+eEciRDCP+T7GjocXG9LNuGpt76MUXxbV2CGGq+gVvTs/kE5oN5kH2/51skjiFkgwl9Qfao\nuGYK9uWVGuRvL9dmhxk=",
     "certificateUrl"=>"https://fps.sandbox.amazonaws.com/certs/090910/PKICert.pem?requestId=bjyoi7ibdlseql3rkc05z9rexucetcjqkdw8eneo5qlto7zp7ap",
     "signatureMethod"=>"RSA-SHA1",
     "expiry"=>"08/2014",
     "status"=>"SC"}
  end

  describe 'with bad certificateUrl (whitespace)' do
    before(:all) do
      @params = {"tokenID"=>"F36RX66AJJF8S3QZ9MP656MAZD2CL3UH5HMIFT75D5ACN6Z9FKCHESAQQXNLVSBM",
                 "signatureVersion"=>"2",
                 "callerReference"=>"OrderToken-00b6fad394cdef8f95c1dcc72e2bfae06dc09c4f",
                 "signature"=>"Jy7oVloTqVl1BKTnFmpiBW0Jpzr3x4E4WoIPxUQMz1vefNO3bhceHTg+zAvB52JcyS2oYmUHltep\n3ifJb+eEciRDCP+T7GjocXG9LNuGpt76MUXxbV2CGGq+gVvTs/kE5oN5kH2/51skjiFkgwl9Qfao\nuGYK9uWVGuRvL9dmhxk=",
                 "certificateUrl"=>"https://fps.sandbox.amazonaws.com/certs/090
    910/PKICert.pem?requestId=bjyoi7ibdlseql3rkc05z9rexucetcjqkdw8eneo5qlto7zp7ap",
                 "signatureMethod"=>"RSA-SHA1",
                 "expiry"=>"08/2014",
                 "status"=>"SC"}
      @pipeline_response = Remit::PipelineResponse.new("https://staging.timeperks.net/member/restaurants/31/thankyou", @params, remit_api, SECRET_KEY)
    end

    it 'should not be valid' do
      @pipeline_response.should_not be_valid
    end
  end

  describe 'with bad signature (whitespace)' do
    before(:all) do
      @params = {"tokenID"=>"F36RX66AJJF8S3QZ9MP656MAZD2CL3UH5HMIFT75D5ACN6Z9FKCHESAQQXNLVSBM",
                 "signatureVersion"=>"2",
                 "callerReference"=>"OrderToken-00b6fad394cdef8f95c1dcc72e2bfae06dc09c4f",
                 "signature"=>"Jy7oVl
    oTqVl1BKTnFmpiBW0Jpzr3x4E4WoIPxUQMz1vefNO3bhceHTg+zAvB52JcyS2oYmUHltep\n3ifJb+eEciRDCP+T7GjocXG9LNuGpt76MUXxbV2CGGq+gVvTs/kE5oN5kH2/51skjiFkgwl9Qfao\nuGYK9uWVGuRvL9dmhxk=",
                 "certificateUrl"=>"https://fps.sandbox.amazonaws.com/certs/090910/PKICert.pem?requestId=bjyoi7ibdlseql3rkc05z9rexucetcjqkdw8eneo5qlto7zp7ap",
                 "signatureMethod"=>"RSA-SHA1",
                 "expiry"=>"08/2014",
                 "status"=>"SC"}
      @pipeline_response = Remit::PipelineResponse.new("https://staging.timeperks.net/member/restaurants/31/thankyou", @params, remit_api, SECRET_KEY)
    end

    it 'should not be valid' do
      @pipeline_response.should_not be_valid
    end
  end

  #'action' and 'controller' are auto removed by remit.
  describe 'with parameters created by rails (not from Amazon, like "id")' do
    before(:all) do
      @params = correct_params.merge({
                 "action"=>"thankyou",
                 "id"=>"31",
                 "controller"=>"member/restaurants"})
      @pipeline_response = Remit::PipelineResponse.new("https://staging.timeperks.net/member/restaurants/31/thankyou", @params, remit_api, SECRET_KEY)
    end

    it 'should not be valid' do
      @pipeline_response.should_not be_valid
    end
  end

  describe 'with trailing slash on endpoint' do
    before(:all) do
      @pipeline_response = Remit::PipelineResponse.new("https://staging.timeperks.net/member/restaurants/31/thankyou/", correct_params, remit_api, SECRET_KEY)
    end

    it 'should not be valid' do
      @pipeline_response.should_not be_valid
    end
  end

  describe "with correct parameters" do
      #'action' and 'controller' are auto removed by remit.
    describe 'including action and controller added by rails' do
      before(:all) do
        @params = correct_params.merge({
                 "action"=>"thankyou",
                 "controller"=>"member/restaurants"})
        @pipeline_response = Remit::PipelineResponse.new("https://staging.timeperks.net/member/restaurants/31/thankyou", @params, remit_api, SECRET_KEY)
      end

      it 'should be valid' do
        @pipeline_response.should be_valid
      end
    end

    describe 'with trailing slash on endpoint URL' do
      before(:all) do
        @pipeline_response = Remit::PipelineResponse.new("https://staging.timeperks.net/member/restaurants/31/thankyou/", correct_params, remit_api, SECRET_KEY)
      end

      it 'should not be valid' do
        @pipeline_response.should_not be_valid
      end
    end

    describe 'without trailing slash on endpoint URL' do
      before(:all) do
        @pipeline_response = Remit::PipelineResponse.new("https://staging.timeperks.net/member/restaurants/31/thankyou", correct_params, remit_api, SECRET_KEY)
      end

      it 'should be valid' do
        @pipeline_response.should be_valid
      end
    end
  end
end
