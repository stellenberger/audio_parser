# frozen_string_literal: true

require_relative 'wave_file'
require_relative 'xml_builder'
require 'nokogiri'

module Models
  # A class to parse audio files (linter suggested this comment)
  class Parser
    def initialize(input_directory, xml_builder = XMLBuilder)
      @input_directory = input_directory
      @xml_builder = xml_builder
    end

    def parse_audio_files
      no_of_files = 0

      Dir.glob("#{@input_directory}/*.wav").each do |file|
        no_of_files += 1

        wave_file = Models::WaveFile.new(file)

        @xml_builder.new(wave_file).build_xml_file
      end

      raise "No files with .wav extension found" if no_of_files == 0
    end
  end
end
