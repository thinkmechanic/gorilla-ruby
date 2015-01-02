require 'spec_helper'

RSpec.describe_request_middleware Gorilla::Middleware::UserAgent do
  it "sets the User-Agent header" do
    result = process(nil)
    agent = result[:request_headers]['user-agent']
    expect(agent).to eq("Gorilla Ruby Client/#{Gorilla::VERSION}")
  end
end
