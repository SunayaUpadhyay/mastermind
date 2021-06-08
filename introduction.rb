# frozen_string_literal: true

require_relative 'code'

# the introduction of the game
module Introduction
  def game_intro
    puts <<~INTRO

      #{'MASTERMIND'.bold.red}

      This is a #{'one'.italic} player game.

      You can either play as a codemaker or a codebreaker.

      If you play as a codebreaker, the computer sets up a pattern
      of four digits numbers in range 1 to 6.

      An example code by the codemaker would be:

      #{Code.new(%w[1 4 6 4])}

      As you can see #{'dublicates'.underline} are also allowed when setting
      the code.

      As a codebreaker, you need to guess the pattern, in both order
      and number, within twelve turns. Each guess is made by entering
      four digits numbers of range 1-6 into the terminal.

      For each guess you make clues are given to you.
        #{"\u2022".red} means that one of your number is correct and in correct order
        \u25E6 means that one of your number is correct but not in correct order

      For the code above, if you entered: 1145

      #{Code.new(%w[1 1 4 5])}

      The clues would be: #{show_clues(Code.new(%w[1 1 4 5]).get_clues(%w[1 4 6 4]))}
        One #{"\u2022".red} for the correct placement of 1 at the beginning
        One \u25E6 for the correct number 4 but incorrect placement

      If you play as the codemaker, you'll need to set up a code and
      the computer will try to guess your code.

      So let's begin shall we?
    INTRO
  end
end
