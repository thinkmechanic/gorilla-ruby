require 'spec_helper'

RSpec.describe_response_middleware Gorilla::Middleware::HttpExceptions do

  {
    400 => Gorilla::BadRequest,
    401 => Gorilla::Unauthorized,
    404 => Gorilla::NotFound,
    422 => Gorilla::ValidationError,
    500 => Gorilla::ServerError,
    503 => Gorilla::ServerError
  }.each do |status, error|
    it "raises a #{error.name} for HTTP status code #{status}" do
      expect { process(nil, status) }.to raise_error(error)
    end
  end

  it 'raises a Gorilla::Error with the correct message from a Hash' do
    expect {
      process({'error' => {'code' => 'code', 'message' => 'message'}}, 400)
    }.to raise_error(Gorilla::Error, '400: code - message')
  end

  it 'raises a Gorilla::Error with the correct message from a String' do
    expect {
      process('This is a string', 400)
    }.to raise_error(Gorilla::Error, '400: This is a string')
  end
end
