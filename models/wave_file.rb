# frozen_string_literal: true

module Models
  # A class to encapsulate wave file properties (linter suggests adding this comment)
  class WaveFile
    attr_reader :file_name, :audio_format, :channel_count, :sampling_rate, :bit_depth, :byte_rate, :bit_rate

    def initialize(file)
      @file_name = file
      parse
    end

    def file_name_without_extension
      @file_name.split('/').last.chomp('.wav')
    end

    private

    def parse
      # Source of mapping: https://ccrma.stanford.edu/courses/422-winter-2014/projects/WaveFormat/
      File.open(file_name, 'rb') do |file|
        # Seperating the chunks
        header_chunk = file.read(12)

        raise 'Input file is not a wave file' unless is_a_wave_file?(header_chunk)

        format_chunk = file.read(24)

        @audio_format = calculate_audio_format(format_chunk)
        @channel_count = get_channel_count(format_chunk)
        @sampling_rate = get_sampling_rate(format_chunk)
        @byte_rate = get_byte_rate(format_chunk)
        @bit_depth = get_bit_depth(format_chunk)
        @bit_rate = calculate_bit_rate(sampling_rate, bit_depth, channel_count)
      end
    end

    def is_a_wave_file?(header_chunk)
      header_chunk[0..3] == 'RIFF' && header_chunk[8..11] == 'WAVE'
    end

    def calculate_bit_rate(sampling_rate, bit_depth, channel_count)
      sampling_rate * bit_depth * channel_count
    end

    def calculate_audio_format(format_chunk)
      audio_format = format_chunk[8..9].unpack1('v')
      if audio_format == 1
        :PCM
      else
        :Compressed
      end
    end

    def get_channel_count(format_chunk)
      format_chunk[10..11].unpack1('v')
    end

    def get_sampling_rate(format_chunk)
      format_chunk[12..15].unpack1('v')
    end

    def get_byte_rate(format_chunk)
      format_chunk[16..19].unpack1('V')
    end

    def get_bit_depth(format_chunk)
      format_chunk[21..22].unpack1('n')
    end
  end
end
