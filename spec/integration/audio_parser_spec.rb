require_relative '../../models/parser'
require_relative '../../models/wave_file'
require_relative '../../models/xml_builder'

require 'timecop'

RSpec.describe Models::Parser do
  let(:input_directory) { 'input_files' }
  let(:expected_files) do
    [
      'sample-file-1.txt',
      'sample-file-2',
      'sample-file-3.wav',
      'sample-file-4.wav',
      'sample-file-5.png'
    ]
  end

  before do
    # as external files are a dependency for this test
    # we will run a quick validation to check that we don't get any false fails
    unless Dir.exist?(input_directory) && expected_files.all? { |file| File.exist?(File.join(input_directory, file)) }
      fail "You don't have the correct example files to run this integration test"
    end
  end

  describe '#parse_audio_files' do
    it 'creates xml files from valid wav files' do
      audio_parser = described_class.new(input_directory)

      timestamp = Timecop.freeze(Time.local(2020, 10, 5, 12, 0, 0)).to_i

      audio_parser.parse_audio_files

      expected_output_files = ['sample-file-3.xml', 'sample-file-4.xml']

      expected_output_files.map do |file|
        expect(File.exist?("output/#{timestamp}/#{file}")).to be true
      end
    end

    it 'does not create xml files from non-wav files' do
      audio_parser = described_class.new(input_directory)

      timestamp = Timecop.freeze(Time.local(2020, 10, 5, 12, 0, 0)).to_i

      audio_parser.parse_audio_files

      non_expected_output_files = ['sample-file-1.xml', 'sample-file-2.xml', 'sample-file-5.xml']

      non_expected_output_files.map do |file|
        expect(File.exist?("output/#{timestamp}/#{file}")).to be false
      end
    end
  end
end
