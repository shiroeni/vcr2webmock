# frozen_string_literal: true

require 'irb'

module Vcr2webmock
  module Vcr
    class Cassette
      # @param [Hash{String -> Object}] data YAML parser preloader
      def initialize(data)
        @data = data
      end

      # Returns any object by key
      #
      # @return [Object]
      def [](key)
        data[key.to_s]
      end

      # Checks VCR or not
      #
      # @return [Boolean]
      def vcr?
        self['recorded'].include?('VCR')
      end

      def requests
        @requests ||=
          data['http_interactions'].map do
            Request.new(_1['request'])
          end
      end

      # @return [Vcr2Webmock::Vcr::Response]
      def response
        @response ||=
          data['http_interactions'].map do
            Response.new(_1['response'])
          end
#        @response ||= Response.new(request_data['response'])
      end



      # Creates file and fills with {}
      #
      # @param [Pathname] directory_path Directory, that contains cassette
      # @return [Pathname]
      def save_fixture(directory_path)
        # TODO: parse multipart
      end

      private

      attr_reader :data
    end
  end
end
