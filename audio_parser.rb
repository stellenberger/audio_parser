# frozen_string_literal: true

require 'wavefile'
require_relative 'models/wave_file'

# A class to parse audio files
class AudioParser
  def initialize(input_directory, wave_parser = WaveFile::Reader)
    @input_directory = input_directory
    @wave_parser = wave_parser
  end

  def parse_audio_files
    Dir.glob("#{@input_directory}/*.wav").each do |file|
      puts "Processing wave: #{file}"
      reader = @wave_parser.new(file)

      Models::WaveFile.new(
        reader.native_format.audio_format,
        reader.native_format.channels,
        reader.native_format.sample_rate,
        reader.native_format.bits_per_sample,
        reader.native_format.byte_rate
      )
    end
  end
end

INPUT_DIRECTORY = ARGV[0]

if INPUT_DIRECTORY.nil?
  puts 'Please provide the input directory'
  exit
end

audio_parser = AudioParser.new(INPUT_DIRECTORY)
audio_parser.parse_audio_files
