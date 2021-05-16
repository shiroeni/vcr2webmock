# frozen_string_literal: true

module Vcr2webmock
  module Vcr
    class Request
      # @param [Hash{String -> Object}] request_data Part of cassette, that relate to request part
      def initialize(request_data)
        @request_data = request_data
      end

      # Address of request
      #
      # @return [String]
      def address
        request_data['uri']
      end

      # HTTP method
      #
      # @return [String]
      def method
        request_data['method']
      end

      # HTTP headers
      #
      # @return [Array<String>]
      def headers
        request_data['headers']
      end

      # Encoding of body
      #
      # @return [String]
      def encoding
        request_data.dig('body', 'encoding') || 'UTF-8'
      end

      # Body of request
      #
      # @return [String]
      def body
        request_data.dig('body', 'string').to_s
      end

      private

      attr_reader :request_data
    end
  end
end
