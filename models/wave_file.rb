# frozen_string_literal: true

module Models
  # A class to encapsulate wave file properties (linter suggests adding this comment)
  class WaveFile
    attr_reader :file_name, :audio_format, :channel_count, :sampling_rate, :bit_depth, :byte_rate, :bit_rate

    def initialize(file_name, audio_format, channel_count, sampling_rate, bit_depth, byte_rate)
      @file_name = file_name
      @audio_format = calculate_audio_format(audio_format)
      @channel_count = channel_count
      @sampling_rate = sampling_rate
      @bit_depth = bit_depth
      @byte_rate = byte_rate
      @bit_rate = calculate_bit_rate(sampling_rate, bit_depth, channel_count)
    end

    def file_name_without_extension
      @file_name.split('/').last.chomp('.wav')
    end

    private

    def calculate_bit_rate(sampling_rate, bit_depth, channel_count)
      sampling_rate * bit_depth * channel_count
    end

    def calculate_audio_format(audio_format)
      if audio_format == '1'
        :PCM
      else
        :Compressed
      end
    end
  end
end
