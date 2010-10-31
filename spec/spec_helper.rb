# figure out where we are being loaded from
if $LOADED_FEATURES.grep(/spec\/spec_helper\.rb/).any?
  begin
    raise "foo"
  rescue => e
    puts <<-MSG
  ===================================================
  It looks like spec_helper.rb has been loaded
  multiple times. Normalize the require to:

    require "spec/spec_helper"

  Things like File.join and File.expand_path will
  cause it to be loaded multiple times.

  Loaded this time from:

    #{e.backtrace.join("\n    ")}
  ===================================================
    MSG
  end
end

require 'rubygems'
require 'spec'

require File.expand_path(File.dirname(__FILE__) + '/../lib/remit')

def remit(access_key = ACCESS_KEY, seret_key = SECRET_KEY)
  @remit ||= Remit::API.new(access_key, seret_key, true)
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
