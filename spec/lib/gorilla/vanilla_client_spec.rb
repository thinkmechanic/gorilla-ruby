require 'spec_helper'

RSpec.describe Gorilla::VanillaClient do

  let(:client) { Gorilla::VanillaClient.new }

  describe 'initializing' do
    it 'uses the url from Gorilla.configuration given no :url option' do
      expect(Faraday).to receive(:new).with(Gorilla.configuration.api.url)
      Gorilla::VanillaClient.new
    end

    it 'overrides the url given a :url options' do
      expect(Faraday).to receive(:new).with('http://test.com/')
      Gorilla::VanillaClient.new(url: 'http://test.com/')
    end

    it 'yields correctly' do
      Gorilla::VanillaClient.new do |conn, options|
        expect(conn).to be_a(Faraday::Connection)
        expect(options).to eq(Gorilla.configuration.api.to_h)
      end
    end

    it 'overrides the default :api configuration options' do
      Gorilla::VanillaClient.new(key: 'test-key') do |conn, options|
        expect(options[:key]).to eq('test-key')
      end
    end

    it 'builds the default stack' do
      conn_stub = double('Faraday::Connection', {
        adapter: nil,
        request: nil,
        response: nil
      })

      expect(Faraday).to receive(:new).and_yield(conn_stub)

      expect_stack conn_stub,
        [:request, :user_agent, Gorilla.configuration.user_agent],
        [:request, :json],
        [:response, :json, content_type: /\bjson$/],
        [:adapter, Gorilla.configuration.client_adapter]

      Gorilla::VanillaClient.new
    end
  end

  [:get, :post, :put, :delete].each do |verb|
    describe "##{verb}" do
      it 'delegates to connection' do
        expect(client.connection).to receive(verb)
          .with('/path', {param: 'value'})
          .and_return(nil)

        client.send(verb, '/path', {param: 'value'})
      end
    end
  end

  describe '#connection' do
    subject { client.connection }
    it { is_expected.to be_a(Faraday::Connection) }
  end

  private

  def expect_stack(conn, *stacks)
    stacks.each do |stack|
      method, *args = stack
      expect(conn).to receive(method).with(*args)
    end
  end
end
