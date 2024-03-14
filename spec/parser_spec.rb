require_relative '../models/parser'
require_relative '../models/wave_file'
require_relative '../models/xml_builder'

RSpec.describe Models::Parser do
  let(:input_directory) { 'example/files' }
  let(:wave_parser) { double(WaveFile::Reader) }
  let(:xml_builder) { double(Models::XMLBuilder) }
  let(:audio_parser) { described_class.new(input_directory, wave_parser, xml_builder) }
  let(:sample_file) { "#{input_directory}/sample.wav" }
  let(:wave_file) { instance_double(Models::WaveFile) }
  let(:xml_instance) { instance_double(Models::XMLBuilder, build_xml_file: true)}

  before do
    allow(Dir).to receive(:glob).and_return([sample_file])
    allow(wave_parser).to receive(:new).and_return(double('wave_reader', native_format: double(
      'format',
      audio_format: 'PCM',
      channels: 2,
      sample_rate: 44100,
      bits_per_sample: 16,
      byte_rate: 88200
    )))
    allow(xml_builder).to receive(:new).and_return(xml_instance)
    allow(Models::WaveFile).to receive(:new).and_return(wave_file)
  end

  describe '#parse_audio_files' do
    it 'calls the wave_parser new method' do
      expect(wave_parser).to receive(:new).with(sample_file)

      audio_parser.parse_audio_files
    end

    it 'calls the wave_file new method' do
      expect(xml_builder).to receive(:new).with(wave_file)

      audio_parser.parse_audio_files
    end

    it 'calls the build_xml_file on the returned wave instance' do
      expect(xml_instance).to receive(:build_xml_file)

      audio_parser.parse_audio_files
    end
  end
end
