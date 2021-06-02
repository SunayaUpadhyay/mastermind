# frozen_string_literal: true

# code is an array of string
# Manage code function
class Code
  attr_reader :code

  def initialize(code)
    @code = code
  end

  def valid?
    code.all? { |s| s.to_i.between?(1, 6) }
  end

  def generate_code
    Array(4).map { (1..6).to_a.sample }
  end

  def get_clues(original_code, clues = Hash.new(0))
    dublicate = original_code
    code.each_with_index do |s, index|
      if s == original_code[index]
        clues[:colored] += 1
      elsif dublicate.find_index(s)
        clues[:uncolored] += 1
        dublicate.delete_at(dublicate.find_index(s))
      end
    end
    clues
  end
end
