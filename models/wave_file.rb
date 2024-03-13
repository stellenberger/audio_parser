# frozen_string_literal: true

module Models
  # A class to encapsulate wave file properties
  class WaveFile
    attr_reader :audio_format, :channel_count, :sampling_rate, :bit_depth, :byte_rate, :bit_rate

    def initialize(audio_format, channel_count, sampling_rate, bit_depth, byte_rate)
      @audio_format = calculate_audio_format(audio_format)
      @channel_count = channel_count
      @sampling_rate = sampling_rate
      @bit_depth = bit_depth
      @byte_rate = byte_rate
      @bit_rate = calculate_bit_rate(sampling_rate, bit_depth, channel_count)
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

    def to_s
      [
        "Audio Format: #{@audio_format}",
        "Channel Count: #{@channel_count}",
        "Sampling Rate: #{@sampling_rate}",
        "Bit Depth: #{@bit_depth}",
        "Byte Rate: #{@byte_rate}",
        "Bit Rate: #{@bit_rate}"
      ].join("\n")
    end
  end
end
