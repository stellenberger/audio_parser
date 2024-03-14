require_relative 'models/parser'

INPUT_DIRECTORY = ARGV[0]

if INPUT_DIRECTORY.nil?
  puts 'Please provide the input directory'
  exit
end

audio_parser = AudioParser.new(INPUT_DIRECTORY)
audio_parser.parse_audio_files
