# frozen_string_literal: true

require 'wavefile'

# A class to parse audio files
class AudioParser
  include WaveFile

  def initialize(input_directory, wave_parser = Reader)
    @input_directory = input_directory
    @wave_parser = wave_parser
  end

  def parse_audio_files
    Dir.glob("#{@input_directory}/*.wav").each do |file|
      puts "Processing wave: #{file}"
      reader = @wave_parser.new(file)
      audio_format = calculate_audio_format(reader.native_format.audio_format)
      channel_count = reader.native_format.channels
      sample_rate = reader.native_format.sample_rate
      byte_rate = reader.native_format.byte_rate
      bit_depth = reader.native_format.bits_per_sample
      bit_rate = sample_rate * bit_depth * channel_count

      puts "Channels: #{channel_count}"
      puts "Sample rate: #{sample_rate}"
      puts "Byte rate: #{byte_rate}"
      puts "Bits per sample: #{bit_depth}"
      puts "Bit rate: #{bit_rate}"
      puts "Audio format: #{audio_format}"
    end
  end

  def calculate_audio_format(audio_format)
    if audio_format == '1'
      :PCM
    else
      :Compressed
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
