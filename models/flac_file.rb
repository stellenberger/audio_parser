require 'pry'

module Models
  class FlacFile
    attr_writer :sample_rate

    def initialize(file)
      @file = file
      parse
    end

    def parse
      puts "Parsing #{@file}"
      File.open(@file, 'rb') do |file|
        raise "not a flac file " unless file.read(4) == 'fLaC'

        file.read(4)

        file.read(10)

        sample_info = file.read(17).unpack("B20")

        @sample_rate = sample_info.first.to_i(2)

        puts "Sample rate: #{@sample_rate}"
      end
    end
  end
end
