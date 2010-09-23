require 'rubygems'
require 'spec'

require File.dirname(__FILE__) + '/../lib/remit'

def remit
  @remit ||= Remit::API.new(ACCESS_KEY, SECRET_KEY, true)
end

describe 'a successful response', :shared => true do
  #The new API version doesn't return an explicit 'status'
  #Either you get errors or not
  #it 'should return success' do
  #  @response.status.should == 'Success'
  #end

  it 'has no errors' do
    if @response.errors
      @response.errors.should == []
    else
      @response.errors.should be_nil
    end
    #puts "errors = #{@response.errors.class} - #{@response.errors.size}"
    
  end

  it "has a request id" do
    @response.request_id.should_not be_nil
  end
end

describe 'a failed response', :shared => true do
  it "is not successful" do
    @response.should_not be_successful
  end

  it "has a request id" do
    @response.request_id.should_not be_nil
  end

  it "has errors" do
    @response.errors.should_not be_empty
  end
end

describe 'a pending response', :shared => true do
  it "is not successful" do
    @response.should_not be_successful
  end

  it "has a request id" do
    @response.request_id.should_not be_nil
  end

  it 'has no errors' do
    if @response.errors
      @response.errors.should == []
    else
      @response.errors.should be_nil
    end
  end
end
