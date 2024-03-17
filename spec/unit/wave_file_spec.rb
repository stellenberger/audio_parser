require_relative '../../models/wave_file'

RSpec.describe Models::WaveFile do
  let(:input_directory) { 'input_files' }
  let(:input_file) { 'sample-file-3.wav' }
  let(:file_location) { File.join(input_directory, input_file) }

  before do
    # as external files are a dependency for this test
    # we will run a quick validation to check that we don't get any false fails
    unless Dir.exist?(input_directory) && File.exist?(file_location)
      fail "You don't have the correct example files to run this integration test"
    end
  end

  describe 'initialization and attribute readers' do
    subject(:wave_file) { described_class.new(file_location) }

    it 'initializes with correct attributes' do
      expect(wave_file.file_name_without_extension).to eq('sample-file-3')
      expect(wave_file.file_name).to eq(file_location)
      expect(wave_file.channel_count).to eq(2)
      expect(wave_file.sampling_rate).to eq(44100)
      expect(wave_file.bit_depth).to eq(16)
      expect(wave_file.byte_rate).to eq(176400)
      expect(wave_file.bit_rate).to eq(1411200)
    end
  end

  describe 'extra properties calculation in private methods' do
    subject(:wave_file) { described_class.new(file_location) }

    describe '#calculate_bit_rate' do
      it 'calculates the correct bit rate' do
        expect(wave_file.send(:calculate_bit_rate, 44100, 16, 2)).to eq(1411200)
        expect(wave_file.send(:calculate_bit_rate, 1, 1, 1)).to eq(1)
        expect(wave_file.send(:calculate_bit_rate, 1, 10000, 0)).to eq(0)
      end
    end
  end
end
