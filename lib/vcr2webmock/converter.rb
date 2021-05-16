# frozen_string_literal: true

module Vcr2webmock
  class Converter
    # @param [Pathfile] path_file
    def initialize(path_file)
      @path_file = path_file
    end

    # Parses file from #path_file, outputs into STDOUT converted code
    #
    # @return [void]
    def convert
      Vcr.process(path_file)
    end

    private

    attr_reader :path_file
  end
end
