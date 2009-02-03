require 'rubygems'
require 'spec'

require File.dirname(__FILE__) + '/../lib/remit'

def remit
  @remit ||= Remit::API.new(ACCESS_KEY, SECRET_KEY, true)
end

describe 'a successful response', :shared => true do
  it 'should return success' do
    @response.status.should == 'Success'
  end

  it 'should not have any errors' do
    @response.errors.should be_nil
  end

  it 'should have a request ID' do
    @response.request_id.should_not be_nil
  end
end

describe 'a failed response', :shared => true do
  it "is not successful" do
    @response.should_not be_successful
  end

  it "has a request id" do
    @response.request_id.should_not be_empty
  end

  it "has errors" do
    @response.errors.should_not be_empty
  end
end
