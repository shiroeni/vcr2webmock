# frozen_string_literal: true

module Vcr2webmock
  module WebMocker
    def self.output
      params = Params.new
      response = Params.new

      yield(params, response)

      $stdout.puts <<~RUBY
        stub(:#{params.method}, '#{params.address}')
          .with(
            headers: #{params.headers},
            body: '#{params.body}'
          )
          .to_return(
            body: '#{response.body}'
          )
      RUBY
    end

    class Params
      attr_accessor :method, :address, :headers, :body
    end
  end
end
