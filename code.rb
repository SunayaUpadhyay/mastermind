# frozen_string_literal: true

# code is an array of string
# Manage code function
class Code
  attr_reader :code

  def initialize(code)
    @code = code
  end

  def valid?
    (code.all? { |s| s.to_i.between?(1, 6) }) && (code.length == 4)
  end

  def self.generate_code
    Array.new(4).map { (1..6).to_a.sample.to_s }
  end

  def get_clues(maker_code)
    { colored: colored_count(maker_code),
      uncolored: uncolored_count(maker_code) }
  end

  def turn_maker_colored(maker_code)
    maker_code.map.with_index { |item, index| item == code[index] ? 'X' : item }
  end

  def turn_breaker_colored(maker_code)
    code.map.with_index { |item, index| item == maker_code[index] ? 'X' : item }
  end

  def colored_count(maker_code)
    turn_maker_colored(maker_code).count('X')
  end

  def uncolored_count(maker_code)
    count = 0
    maker_num = filter_x(turn_maker_colored(maker_code))
    breaker_num = filter_x(turn_breaker_colored(maker_code))
    breaker_num.each do |s|
      if maker_num.find_index(s)
        count += 1
        maker_num.delete_at(maker_num.find_index(s))
      end
    end
    count
  end

  def filter_x(arr)
    arr.filter { |x| x != 'X' }
  end

  def exact_match?(clues)
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
