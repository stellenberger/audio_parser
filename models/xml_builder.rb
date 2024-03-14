# frozen_string_literal: true

require 'fileutils'

# Class for building XML files (linter suggests adding this comment)
module Models
  class XMLBuilder
    attr_reader :content, :wave_file

    def initialize(wave_file)
      @wave_file = wave_file
    end

    def build_xml_file
      @content = Nokogiri::XML::Builder.new(encoding: 'UTF-8') do |xml|
        xml.track do
          xml.format wave_file.audio_format
          xml.channel_count wave_file.channel_count
          xml.sampling_rate wave_file.sampling_rate
          xml.bit_depth wave_file.bit_depth
          xml.byte_rate wave_file.byte_rate
          xml.bit_rate wave_file.bit_rate
        end
      end.to_xml

      generate_file
    end

    private

    def generate_file
      directory = "output/#{Time.now.to_i}"

      ::FileUtils.mkdir_p(directory)

      full_path = File.join(directory, "#{@wave_file.file_name_without_extension}.xml")

      File.open(full_path, 'w') do |file|
        file.write(@content)
      end
    end
  end
end
