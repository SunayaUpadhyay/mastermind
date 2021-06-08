# frozen_string_literal: true

require_relative 'introduction'
require_relative 'computer'
require_relative 'code'

# Main class
class Game
  include Introduction
  include Display

  attr_reader :player, :computer, :breaker_code, :maker_code, :tries, :clues

  GAME_TRIES = 12

  def initialize
    @player = nil
    @computer = nil
    @breaker_code = nil
    @maker_code = nil
    @tries = 0
    @clues = Hash.new(0)
  end

  def play
    puts game_intro
    if codemaker?
      user_play_as_codemaker
    else
      user_play_as_codebreaker
    end
  end

  def user_play_as_codebreaker
    breaker_turns
    conclusion(player.name)
  end

  def user_play_as_codemaker
    @player = create_player
    @computer = Computer.new
    puts prompt_user_maker_code(player.name)
    @maker_code = set_code_from_user
    computer_game_loop
    conclusion('Computer')
  end

  def computer_game_loop
    GAME_TRIES.times do
      @breaker_code = Code.new(computer.make_code)
      output_clues
      computer.receive_clues(clues)
      computer.process_clues(breaker_code.code)
      increment_tries
      break if breaker_code.exact_match?(clues)
    end
  end

  def codemaker?
    puts choice_breaker_or_maker
    case gets.chomp
    when '1' then true
    when '2' then false
    else
      puts error_on_choice_selection
      codemaker?
    end
  end

  def create_player
    print username_prompt
    name = gets.chomp
    Player.new(name)
  end

  def create_new_code
    Code.new(Code.generate_code)
  end

  def set_code_from_user
    code_from_user = Code.new(gets.chomp.split(''))
    until code_from_user.valid?
      puts invalid_code_entry
      code_from_user = Code.new(gets.chomp.split(''))
    end
    code_from_user
  end

  def breaker_turns
    @maker_code = create_new_code
    @player = create_player
    user_game_loop
  end

  def user_game_loop
    GAME_TRIES.times do
      create_breaker_code_from_user
      output_clues
      increment_tries
      break if breaker_code.exact_match?(clues)
    end
  end

  def increment_tries
    @tries += 1
  end

  def create_breaker_code_from_user
    puts user_code_input(player.name)
    @breaker_code = set_code_from_user
  end

  def output_clues
    @clues = breaker_code.get_clues(maker_code.code)
    puts user_output(breaker_code, clues)
  end

  def conclusion(name)
    if breaker_code.exact_match?(clues)
      puts declare_winner(name, tries)
    else
      puts answer(maker_code)
      puts declare_loser(name, tries)
    end
  end
end
