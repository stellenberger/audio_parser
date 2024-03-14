require_relative '../../models/wave_file'

RSpec.describe Models::WaveFile do
  describe 'initialization and attribute readers' do
    subject(:wave_file) { described_class.new('example_file.wav', '1', 2, 44100, 16, 176400) }

    it 'initializes with correct attributes' do
      expect(wave_file.file_name_without_extension).to eq('example_file')
      expect(wave_file.file_name).to eq('example_file.wav')
      expect(wave_file.channel_count).to eq(2)
      expect(wave_file.sampling_rate).to eq(44100)
      expect(wave_file.bit_depth).to eq(16)
      expect(wave_file.byte_rate).to eq(176400)
      expect(wave_file.bit_rate).to eq(1411200)
    end
  end

  describe 'extra properties calculation in private methods' do
    subject(:wave_file) { described_class.new('example_file.wav', '1', 2, 44100, 16, 176400) }

    describe '#calculate_bit_rate' do
      it 'calculates the correct bit rate' do
        expect(wave_file.send(:calculate_bit_rate, 44100, 16, 2)).to eq(1411200)
        expect(wave_file.send(:calculate_bit_rate, 1, 1, 1)).to eq(1)
        expect(wave_file.send(:calculate_bit_rate, 1, 10000, 0)).to eq(0)
      end
    end

    describe '#calculate_audio_format' do
      it 'returns PCM for channel count of 1' do
        expect(wave_file.send(:calculate_audio_format, '1')).to eq(:PCM)
      end

      it 'returns Compressed for all other values' do
        expect(wave_file.send(:calculate_audio_format, rand(2..50000).to_s)).to eq(:Compressed)
      end
    end
  end
end
