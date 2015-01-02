require 'spec_helper'

RSpec.describe Gorilla::Client do

  before do
    Gorilla.configure do |c|
      c.api_key = 'api-key'
      c.api_secret = 'api-secret'
    end
  end

  [:get, :post, :put, :delete].each do |verb|
    describe "##{verb}" do
      let(:client) { Gorilla::Client.new }

      it 'delegates to connection' do
        expect(client.connection).to receive(verb)
          .with('/path', {param: 'value'})
          .and_return(nil)

        client.send(verb, '/path', {param: 'value'})
      end
    end
  end
end
