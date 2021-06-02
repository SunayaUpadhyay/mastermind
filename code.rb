# frozen_string_literal: true

# code is an array of string
# Manage code function
class Code
  attr_reader :code, :clues

  def initialize(code)
    @code = code
    @clues = Hash.new(0)
  end

  def valid?
    (code.all? { |s| s.to_i.between?(1, 6) }) && (code.length == 4)
  end

  def self.generate_code
    Array.new(4).map { (1..6).to_a.sample.to_s }
  end

  def get_clues(original_code) # Fix this, does work as expected 
    dublicate = original_code.map(&:clone)
    code.each_with_index do |s, index|
      if s == original_code[index]
        clues[:colored] += 1
        dublicate.delete_at(dublicate.find_index(s))
      elsif dublicate.find_index(s)
        clues[:uncolored] += 1
        dublicate.delete_at(dublicate.find_index(s))
      end
    end
    @clues = clues
  end

#  def num_of_colored(codemaker_code)
#    colored_count = 0
#    code.each_with_index do |s, index|
#      colored_count += 1 if s == codemaker_code[index]
#    end
#    colored_count
#  end
#
#  def num_of_uncolored
#    code
#  def replace_matched_code(codemaker_code)
#    arr = Array.new(4)
#    code.each_with_index do |s, index|
#      arr[index] = s == codemaker_code[index] ? 'X' : s
#    end
#    arr
#  end

  def exact_match?
    clues[:colored] == 4
  end

  def to_s
    code.map { |s| color("   #{s}   ") }.join(' ')
  end

  private

  def color(str)
    case str.strip
    when '1' then str.bg_blue
    when '2' then str.bg_brown
    when '3' then str.bg_cyan
    when '4' then str.bg_red
    when '5' then str.bg_green
    when '6' then str.bg_magenta
    end
  end
end
