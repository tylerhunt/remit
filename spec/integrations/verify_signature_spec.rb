require File.dirname(__FILE__) + '/integrations_helper'


#TODO: Need to get a positive test in here...
#describe 'a VerifySignature Request fails on bad signature' do
#
#  before(:each) do
#    verify_request = Remit::VerifySignature::Request.new(
#              :url_end_point => "http://vamsik.desktop.amazon.com:8080/ipn.jsp",
#              :version => "2008-09-17",
#              :http_parameters =>
#"expiry%3D08%252F2015%26signature%3DynDukZ9%252FG77uSJVb5YM0cadwHVwYKPMKOO3PNvgADbv6VtymgBxeOWEhED6KGHsGSvSJnMWDN%252FZl639AkRe9Ry%252F7zmn9CmiM%252FZkp1XtshERGTqi2YL10GwQpaH17MQqOX3u1cW4LlyFoLy4celUFBPq1WM2ZJnaNZRJIEY%252FvpeVnCVK8VIPdY3HMxPAkNi5zeF2BbqH%252BL2vAWef6vfHkNcJPlOuOl6jP4E%252B58F24ni%252B9ek%252FQH18O4kw%252FUJ7ZfKwjCCI13%252BcFybpofcKqddq8CuUJj5Ii7Pdw1fje7ktzHeeNhF0r9siWcYmd4JaxTP3NmLJdHFRq2T%252FgsF3vK9m3gw%253D%253D%26signatureVersion%3D2%26signatureMethod%3DRSA-SHA1%26certificateUrl%3Dhttps%253A%252F%252Ffps.sandbox.amazonaws.com%252Fcerts%252F090909%252FPKICert.pem%26tokenID%3DA5BB3HUNAZFJ5CRXIPH72LIODZUNAUZIVP7UB74QNFQDSQ9MN4HPIKISQZWPLJXF%26status%3DSC%26callerReference%3DcallerReferenceMultiUse1&AWSAccessKeyId=AKIAJGC2KB2QP7MVBLYQ&Timestamp=2010-02-26T19:48:05.000Z&version=2008-09-17&signatureVersion=2&signatureMethod=RSA-SHA1&signature=fKRGL42K7nduDA47g6bJCyUyF5ZvkBotXE5jVcgyHvE%3D"
#    )
#    @live_response = remit.verify_signature(verify_request)
#
#    doc = File.read("spec/mocks/errors/InvalidParams_certificateUrl.xml")
#
#    @prerecorded_response = Remit::VerifySignature::Response.new(doc)
#  end
#
#  it "should not be a valid request" do
#    @live_response.errors.first.message.should == @prerecorded_response.errors.first.message
#  end
#
#end
