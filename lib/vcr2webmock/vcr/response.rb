# frozen_string_literal: true

module Vcr2webmock
  module Vcr
    class Response
      # @param [Hash{String -> Object}] response_data Data related to response
      def initialize(response_data)
        @response_data = response_data
      end

      # HTTP status code
      #
      # @return [Integer]
      def status_code
        response_data.dig('status', 'code')
      end

      # HTTP status message
      #
      # @return [String]
      def status_message
        response_data.dig('status', 'message')
      end

      # HTTP headers of response
      #
      # @return [Array<String>]
      def headers
        response_data['headers']
      end

      # Encoding of response's body
      #
      # @return [String]
      def encoding
        response_data.dig('body', 'encoding')
      end

      # @return [String]
      def body
        response_data.dig('body', 'string')
      end

      private

      attr_reader :response_data
    end
  end
end
