# frozen_string_literal: true

# A class to parse audio files
class AudioParser
  def initialize(input_directory)
    @input_directory = input_directory
  end

  def parse_audio_files
    Dir.glob("#{@input_directory}/*.wav").each do |file|
      puts "Processing wave: #{file}"
    end
  end
end

INPUT_DIRECTORY = ARGV[0]

audio_parser = AudioParser.new(INPUT_DIRECTORY)
audio_parser.parse_audio_files
