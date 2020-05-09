require '.lib/card'
require './lib/deck'
require './lib/player'
require './lib/turn'

class Start

  attr_reader :player1
              :player2
              :
  def initialize(player1, player2)
    @player1 = player1
    @player2 = player2

  end

  def start
    p "Welcome to War! (or Peace) This game will be played with 52 cards."
    p "The players today are #{player1.name} and #{player2.name}."
    p "Type 'GO' to start the game."
    p "-" * 66

    input = gets.chomp
    if input.upcase == "GO"
      turn
  end

  def turn

  end

end
