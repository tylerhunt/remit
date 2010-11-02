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
      @pipeline_response = Remit::PipelineResponse.new("https://staging.timeperks.net/member/restaurants/31/thankyou", @params, remit)
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
      @pipeline_response = Remit::PipelineResponse.new("https://staging.timeperks.net/member/restaurants/31/thankyou", @params, remit)
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
      @pipeline_response = Remit::PipelineResponse.new("https://staging.timeperks.net/member/restaurants/31/thankyou", @params, remit)
    end

    it 'should not be valid' do
      @pipeline_response.should_not be_valid
    end
  end

  describe 'with trailing slash on endpoint' do
    before(:all) do
      @pipeline_response = Remit::PipelineResponse.new("https://staging.timeperks.net/member/restaurants/31/thankyou/", correct_params, remit)
    end

    it 'should not be valid' do
      @pipeline_response.should_not be_valid
    end
  end

  describe "with correct parameters hash" do
      #'action' and 'controller' are auto removed by remit.
    describe 'including action and controller added by rails' do
      before(:all) do
        @params = correct_params.merge({
                 "action"=>"thankyou",
                 "controller"=>"member/restaurants"})
        @pipeline_response = Remit::PipelineResponse.new("https://staging.timeperks.net/member/restaurants/31/thankyou", @params, remit)
      end

      it 'should be valid' do
        @pipeline_response.should be_valid
      end
    end

    describe 'with trailing slash on endpoint URL' do
      before(:all) do
        @pipeline_response = Remit::PipelineResponse.new("https://staging.timeperks.net/member/restaurants/31/thankyou/", correct_params, remit)
      end

      it 'should not be valid' do
        @pipeline_response.should_not be_valid
      end
    end

    describe 'without trailing slash on endpoint URL' do
      before(:all) do
        @pipeline_response = Remit::PipelineResponse.new("https://staging.timeperks.net/member/restaurants/31/thankyou", correct_params, remit)
      end

      it 'should be valid' do
        @pipeline_response.should be_valid
      end
    end
  end

  describe "with invalid query params (id comes from rails) and building Endpoint URL from request URI" do
    before(:all) do
      @parameters =  {"tokenID"=>"977B36S3GQ5VRXSNSZ4V2BHJEB9YB3A7MFQSF5GCK5ULGGDMNDJT6AMU1TU6A6XX", "signatureVersion"=>"2", "callerReference"=>"OrderToken-a0fff5d468263da9672a4a939a5b28086764d049", "action"=>"thankyou", "signature"=>"gaumxsAIf4SoY9gp2KWpZK9JRhPhnQ/w+DgC/VWSgw/9pur/RDVlnzGt9Btr9iX6Goc7UNB3nso7\nmm8ocodEtz8Fnsj85OD4NdQZLuFV0PIzsIWYwYfe3nOxUm08uCCJo6dPJMwIocYnGTneqYMGoFZD\nawjzOEpAz8/50lViGvs=", "certificateUrl"=>"https://fps.sandbox.amazonaws.com/certs/090910/PKICert.pem?requestId=bjyoi7ibdlseql3rkc05z9rexucetcjqkdw8eneo5qlto7zp7aq", "id"=>"38", "signatureMethod"=>"RSA-SHA1", "controller"=>"member/restaurants", "expiry"=>"07/2015", "status"=>"SC"}
      url = "https://staging.timeperks.net/member/restaurants/38/thankyou?signature=gaumxsAIf4SoY9gp2KWpZK9JRhPhnQ%2Fw%2BDgC%2FVWSgw%2F9pur%2FRDVlnzGt9Btr9iX6Goc7UNB3nso7%0Amm8ocodEtz8Fnsj85OD4NdQZLuFV0PIzsIWYwYfe3nOxUm08uCCJo6dPJMwIocYnGTneqYMGoFZD%0AawjzOEpAz8%2F50lViGvs%3D&expiry=07%2F2015&signatureVersion=2&signatureMethod=RSA-SHA1&certificateUrl=https%3A%2F%2Ffps.sandbox.amazonaws.com%2Fcerts%2F090910%2FPKICert.pem%3FrequestId%3Dbjyoi7ibdlseql3rkc05z9rexucetcjqkdw8eneo5qlto7zp7aq&tokenID=977B36S3GQ5VRXSNSZ4V2BHJEB9YB3A7MFQSF5GCK5ULGGDMNDJT6AMU1TU6A6XX&status=SC&callerReference=OrderToken-a0fff5d468263da9672a4a939a5b28086764d049"
      @url = URI.parse("#{url}")
    end

    it 'should work when using URL to parse out params instead' do
      @pipeline_response = Remit::PipelineResponse.new("#{@url.scheme}://#{@url.host}#{@url.path}", @url.query, remit)
      @pipeline_response.should be_valid
    end

    it 'should be valid when using :skip_param_keys' do
      @pipeline_response = Remit::PipelineResponse.new("#{@url.scheme}://#{@url.host}#{@url.path}", @parameters, remit, {:skip_param_keys => ['action','controller','id']})
      @pipeline_response.should be_valid
    end

    it 'should be valid when relying on :skip_param_keys to remove action and controller params' do
      @pipeline_response = Remit::PipelineResponse.new("#{@url.scheme}://#{@url.host}#{@url.path}", @parameters, remit, {:skip_param_keys => ['id']})
      @pipeline_response.should be_valid
    end

  end

end
