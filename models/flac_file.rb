require 'pry'

module Models
  class FlacFile
    def initialize(file)
      @file = file
      parse
    end

    def parse
      puts "Parsing #{@file}"
      File.open(@file, 'rb') do |file|
        raise "not a flac file " unless file.read(4) == 'fLaC'

        file.read(4)

        streaminfo_chunk = file.read(27)

        sample_info = streaminfo_chunk[10..12]

        sample_rate_metadata = StringIO.new(sample_info.unpack('B*').first).map{|chunk| chunk[0..-5]}.first.to_i(2)

        puts "Sample rate: #{sample_rate_metadata}"
      end
    end
  end
end
