require File.dirname(__FILE__) + '/integrations_helper'
#require 'uri'
#require 'remit/common'

#TODO: Turn this into an integration test...
#describe "Pipeline Response should work" do
#
#  before(:each) do
#    params = { :status => "SA",
#                    :tokenID => "foo",
#                    :callerReference => "bar",
#                    :awsSignature => "7QrCpQ1nMng3Usaj8LFkeo4zorM="}
#    url = URI.parse("http://example.com/payment?#{params.to_url_params}")
#    @pipeline_response = Remit::PipelineResponse.new(url.path, url.query, SECRET_KEY)
#  end
#
#
#  it "should be valid" do
#    puts "#{@pipeline_response.inspect}"
#    @pipeline_response.should be_valid
#  end
#
#  it "should be successful" do
#    @pipeline_response.successful?.should == true
#  end
#
#end
