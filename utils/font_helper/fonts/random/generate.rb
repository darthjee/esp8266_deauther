#!/usr/local/bin/ruby

class Generator
  attr_reader :pixel_size, :char, :type

  def self.write(**args)
    new(**args).write
  end

  def initialize(pixel_size: 5, char:, type: :blank)
    @pixel_size = pixel_size
    @char = char
    @type = type
  end

  def write
    write_header
    write_bits
    write_blank_line

    file.close
  end

  private

  def write_bits
    bits.each do |bit|
       write_bit(bit)
    end
  end

  def write_bit(bit)
    write_blank_line
    pixel_size.times do
      if bit.zero?
        write_blank_line
      else
        write_full_line
      end
    end
    write_blank_line
  end

  def bits
    [value & 1, (value & 2) / 2, (value & 4)/4]
  end

  def value
    @value ||= char - 48
  end

  def write_header
    file.write("P1\n")
    file.write("#{width} #{height}\n")
    write_blank_line
  end

  def write_full_line
    file.write(full_line)
    file.write("\n")
  end

  def write_blank_line
    file.write(blank_line)
    file.write("\n")
  end

  def blank_line
    @blank_line ||= (width.times.map { 0 } ).join(" ")
  end

  def full_line
    @full_line ||= ([0] + pixel_size.times.map { 1 } + [0]).join(" ")
  end

  def width
    pixel_size + 2
  end

  def height
    width * 3 + 2
  end

  def file_name
    @file_name ||= "#{char}.pbm"
  end

  def file
    @file ||= File.open(file_name, "w")
  end
end

(48..55).to_a.each do |char|
  Generator.write(char:)
end
