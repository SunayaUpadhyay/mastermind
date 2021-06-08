# frozen_string_literal: true

# Computer class
class Computer
  attr_reader :code_sofar, :clues
  attr_accessor :num_left, :possible_orders

  def initialize
    @num_left = ('1'..'6').to_a
    @code_sofar = []
    @clues = nil
    @possible_orders = []
  end

  def make_code
    if code_sofar.length == 4
      find_correct_order
    else
      find_correct_number
    end
  end

  def find_correct_order
    possible_orders.sample
  end

  def find_correct_number
    (code_sofar.join + num_left[0] * (4 - code_sofar.length)).split('')
  end

  def receive_clues(clues)
    @clues = clues
  end

  def process_clues(code)
    if code_sofar.length == 4
      process_for_unordered(code)
    else
      fill_code_sofar
    end
  end

  def process_for_unordered(code)
    if clues[:colored].zero?
      remove_all_in_posn(code)
    else
      possible_orders.delete(code)
    end
  end

  def process_possible_orders
    @possible_orders = code_sofar.permutation.to_a if code_sofar.length == 4
  end

  def fill_code_sofar
    clues_num = clues[:colored] + clues[:uncolored]
    num_to_add = clues_num - code_sofar.length
    @code_sofar.concat((num_left[0] * num_to_add).split(''))
    process_possible_orders
    @num_left.shift
  end

  def remove_all_in_posn(code)
    possible_orders.filter! do |arr|
      !(arr[0] == code[0] || arr[1] == code[1] || arr[2] == code[2] || arr[3] == code[3])
    end
  end
end
