require './lib/card'
require './lib/deck'
require './lib/player'

class Turn
  attr_reader :player1,
              :player2,
              :spoils_of_war,
              :type

  def initialize(player1, player2)
    @player1 = player1
    @player2 = player2
    @spoils_of_war = []
    @type = type_of_turn
  end

  def type_of_turn
    if player1.deck.rank_of_card_at(0) == player2.deck.rank_of_card_at(0) &&
       player1.deck.rank_of_card_at(2) == player2.deck.rank_of_card_at(2)
       :mutually_assured_destruction
    elsif
       player1.deck.rank_of_card_at(0) == player2.deck.rank_of_card_at(0)
       :war
    else
       player1.deck.rank_of_card_at(0) != player2.deck.rank_of_card_at(0)
       :basic
    end
  end

  def winner
    if type == :basic
      return player1 if player1.deck.rank_of_card_at(0) > player2.deck.rank_of_card_at(0)
      return player2 if player1.deck.rank_of_card_at(0) < player2.deck.rank_of_card_at(0)
    elsif type == :war
      return player1 if player1.deck.rank_of_card_at(2) > player2.deck.rank_of_card_at(2)
      return player2 if player1.deck.rank_of_card_at(2) < player2.deck.rank_of_card_at(2)
    else type == :mutually_assured_destruction
       "No Winner"
    end
  end

  def pile_cards
    if type == :basic
      @spoils_of_war << player1.deck.cards.shift
      @spoils_of_war << player2.deck.cards.shift
    elsif type == :war
      @spoils_of_war << player1.deck.cards.slice!(0..2)
      @spoils_of_war << player2.deck.cards.slice!(0..2)
    else type == :mutually_assured_destruction
      player1.deck.cards.slice!(0..2)
      player2.deck.cards.slice!(0..2)
    end
  end

  def award_spoils(winner)
    winner.deck.cards << @spoils_of_war
    winner.deck.cards.flatten!
    @spoils_of_war = []
  end

  def start
    p "Welcome to War! (or Peace) This game will be played with 52 cards."
    p "The players today are #{player1.name} and #{player2.name}."
    p "Type 'GO' to start the game."
    p "-" * 66

    entry = gets.chomp
    input = gets.chomp
  end
end
