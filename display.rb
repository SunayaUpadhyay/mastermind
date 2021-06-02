# frozen_string_literal: true

# All terminal displays.
module Display
  def game_intro
    'This is game intro.'
  end

  def choice
    'Do you want to be a codemaker or codebreaker (M or D)?'
  end

  def user_input(username)
    "#{username}, please enter a 4 digit code in the range 1-6 inclusive"
  end

  def username_prompt
    'What should we call you?'
  end

  def user_output(code)
    "#{code}   #{show_clues}"
  end

  def invalid_code_entry
    "The code you entered isn't in range (1-6).".red
  end

  def answer(code)
    "The correct code was #{code}"
  end

  def give_code(player)
    "#{player}, please enter a code for the computer"
  end

  def show_clues(clues)
    "Clues:   #{("\u2022" * clues[:colored]).red}  #{"\u25E6" * clues[:uncolored]}"
  end
end
