# frozen_string_literal: true

require_relative 'display'
require_relative 'player'
require_relative 'game'
require_relative 'feedback'
require_relative 'string'
require_relative 'code'

def play_game
  game = Game.new
  game.play
  repeat_game
end

def repeat_game
  puts Display.prompt_play_again
  play_game if gets.chomp.downcase == 'y'
  puts Display.end_credits
end

play_game
