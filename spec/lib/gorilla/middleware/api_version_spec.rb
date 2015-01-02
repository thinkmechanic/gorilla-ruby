require 'spec_helper'

RSpec.describe_request_middleware Gorilla::Middleware::ApiVersion do
  let(:version) { 1 }
  let(:args) { [version] }

  it "sets the Accept header" do
    result = process(nil)
    accept = result[:request_headers]['accept']
    expect(accept).to eq("application/vnd.gorilla.v#{version}+json")
  end
end
