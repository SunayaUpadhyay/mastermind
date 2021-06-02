# frozen_string_literal: true

# Main class
class Game
  include Display
  def play
    puts game_intro
  end

  def create_player
    puts username_prompt
    name = gets.chomp
    Player.new(name)
  end

  def turns(username)
    12.times do
      user_input(username)
      
end
