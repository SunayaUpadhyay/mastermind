# frozen_string_literal: true

# Main class
class Game
  include Display

  attr_reader :player, :breaker_code, :maker_code, :tries

  GAME_TRIES = 12

  def initialize
    @player = nil
    @breaker_code = nil
    @maker_code = nil
    @tries = nil
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
    conclusion
  end

  def user_play_as_codemaker
    @maker_code = set_code_from_user
  end

  def codemaker?
    puts choice_breaker_or_maker
    case gets.chomp
    when '1' then true
    when '2' then false
    else 
      error_on_choice_selection
      codemaker?
    end
  end

  def create_player
    puts username_prompt
    name = gets.chomp
    Player.new(name)
  end

  def create_new_code
    Code.new(Code.generate_code)
  end

  def set_code_from_user
    code_from_user = Code.new(gets.chomp.split(''))
    unless code_from_user.valid?
      puts invalid_code_entry
      set_code_from_user
    end
    code_from_user
  end

  def breaker_turns
    @maker_code = create_new_code
    @player = create_player
    GAME_TRIES.times do |n|
      create_breaker_code_from_user
      output_clues
      @tries = n + 1
      break if breaker_code.exact_match?
    end
  end

  def create_breaker_code_from_user
    puts user_code_input(player.name)
    @breaker_code = set_code_from_user
  end

  def output_clues
    puts user_output(breaker_code, breaker_code.get_clues(maker_code.code)) # shorten this
  end

  def conclusion
    if breaker_code.exact_match?
      puts declare_winner(player.name, tries)
    else
      puts declare_loser(player.name, tries)
    end
    puts answer(maker_code)
  end
end
