# frozen_string_literal: true

module Vcr2webmock
  module Vcr
    class Converter
      # @param [Pathname] path_file Pathname instance that contains path to file
      # @param [Hash{Symbol -> Object}] options Additional options for convertation
      def initialize(path_file, options = {})
        @path_file = path_file

        @options = options
      end

      # Process convertation from VCR cassettes to WebMock and outputs result to STDOUT
      #
      # @return [nil]
      def convert
        $stdout.puts "# #{path_file}"

        cassette.requests.each_with_index do |request, idx|
          WebMocker.output do |params, response|
            params.body = request.body
            params.method = request.method
            params.address = request.address

            # TODO: It can be optionable
            params.headers = request.headers.each_with_object({}) do |(key, value), accepted_headers|
              if %w[Content-Type Authorization].include?(key)
                accepted_headers[key] = value.first
              end

              accepted_headers
            end.to_s # enforce #to_s for preventing default STDOUT formatting of Hash

            params.body = body_for(request)

            response.body = cassette.response[idx].body
          end
        end
      end

      private

      # @return [Pathname]
      attr_reader :path_file

      # @return [Hash{String -> Object}]
      attr_reader :options

      # Body for WebMock (extract as is or extract to fixture)
      #
      # @param [Vcr2Webmock]
      # @return [String]
      def body_for(request)
        if options[:save_fixture]
          file_path = request.save_fixture(path_file.dirname)

          "file_fixture('#{file_path}')"
        else
          request.body
        end
      end

      # @return [Vcr2webmock::Preloaders::Vcr::Cassette]
      def cassette
        @cassette ||= Cassette.new(YAML.load_file(path_file))
      end
    end
  end
end
