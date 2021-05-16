# frozen_string_literal: true

module Vcr2webmock
  module Vcr
    def self.process(path_file)
      Vcr::Converter.new(path_file).convert
    end
  end
end
