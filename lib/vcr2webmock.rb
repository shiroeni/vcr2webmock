# frozen_string_literal: true

require 'yaml'
require 'pathname'

require 'zeitwerk'

require 'vcr2webmock/version'

loader = Zeitwerk::Loader.for_gem
loader.setup

module Vcr2webmock
  class Error < StandardError; end

  class FileNotExists < Error; end

  module_function

  # Main entrypoint to convertation function. Receives file path,
  # outputs WebMock's code.
  #
  # @param [String] direct_path Direct path to file or directory with cassettes
  def convert(direct_path)
    pathfile = Pathname.new(direct_path)

    raise FileNotExists, "File or directory isn't exists" unless pathfile.exists?

    if pathfile.directory?
      convert_childs(pathfile)
    else
      convertation(pathfile)
    end
  rescue Error => e
    puts e.message
  end

  private

  # @param [Pathfile] pathfile Pathfile instanse that relate cassette
  def convertation(pathfile)
    Converter.new(pathfile).convert
  end

  # @param [Pathfile] pathfile Pathfile instance that relate directory
  def convert_childs(pathfile)
    pathfile&.children do
      convert_childs(_1) if _1.directory?

      puts _1.to_s
      convertation(_1)
      puts "######\n\n\n"
    end
  end
end

loader.eager_load
