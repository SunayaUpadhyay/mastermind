# frozen_string_literal: true

# All terminal displays.
module Display
  # need to fill this
  def game_intro
    'This is game intro.'
  end

  def self.prompt_play_again
    'Do you want to play again? Press Y to continue'
  end

  def self.end_credits
    'Thank you for playing!'
  end

  def choice_breaker_or_maker
    'Do you want to be a codemaker or codebreaker?
    # Press 1 if you want to be a codemaker
    # Press 2 if you want to be a codebreaker'
  end

  def error_on_choice_selection
    'Please press 1 or 2 only.'.red
  end

  def user_code_input(username)
    "#{username}, please enter a 4 digit code in the range 1-6 inclusive"
  end

  def username_prompt
    'What should we call you?'
  end

  def user_output(code, clues)
    "#{code}   #{show_clues(clues)}"
  end

  def invalid_code_entry
    'The code you entered is either out of range (1-6) or is not 4 digits long'.red
  end

  def answer(code)
    "The correct code was #{code}"
  end

  def give_code
    'Please enter a code for the computer'
  end

  def show_clues(clues)
    "Clues: #{("\u2022" * clues[:colored]).red}#{"\u25E6" * clues[:uncolored]}"
  end

  def declare_winner(username, tries)
    "Congratulation, #{username} you have cracked the code in #{tries} tries."
  end

  def declare_loser(username, tries)
    "#{username} were unable to crack the code in #{tries} tries."
  end
end
