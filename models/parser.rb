# frozen_string_literal: true

require 'wavefile'
require_relative 'wave_file'
require_relative 'xml_builder'
require 'nokogiri'

module Models
  # A class to parse audio files (linter suggested this comment)
  class Parser
    def initialize(input_directory, wave_parser = ::WaveFile::Reader, xml_builder = XMLBuilder)
      @input_directory = input_directory
      @wave_parser = wave_parser
      @xml_builder = xml_builder
    end

    def parse_audio_files
      Dir.glob("#{@input_directory}/*.wav").each do |file|
        reader = @wave_parser.new(file)

        wave_file = Models::WaveFile.new(
          file,
          reader.native_format.audio_format,
          reader.native_format.channels,
          reader.native_format.sample_rate,
          reader.native_format.bits_per_sample,
          reader.native_format.byte_rate
        )

        @xml_builder.new(wave_file).build_xml_file
      end
    end
  end
end
