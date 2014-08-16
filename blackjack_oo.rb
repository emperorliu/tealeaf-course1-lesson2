# Blackjack in OO

# major nouns/verbs in blackjack: 
# - deck
#   - deal
    #-scramble
# - card
#   - suit / face value
# - dealer
#   - hit/stay
#   - name
#   - total
# - player
#   - hit/stay
#   - name
#   - total
# - gameplay
#   - compare total

# first, we have a deck of 52 cards (how to organize data?)
#   - suits value worth 10
#   - aces value worth 11 or 1

# dealer is dealt 2 cards at random
# player is dealt 2 cards at 

# player goes: choose hit or stay
#   - if hit, dealt another card (until stay)
#     - take sum of cards
#       - if sum more than 21, player bust
#   - if stay, take total sum of cards

# dealer goes: choose hit or stay
#   - if sum of cards <= 17, hit
#   - if sum more than 21, dealer bust
#   - else stay

# - compare sum of player and dealer
require 'rubygems'
require 'pry'

class Deck
  attr_accessor :cards

  def initialize
    @cards = []
    ['Hearts','Diamonds','Clubs','Spades'].each do |suit|
      [ 2, 3, 4, 5, 6, 7, 8, 9, 10, 'J', 'Q', 'K', 'A'].each do |value|
        @cards<<Card.new(suit,value)
      end
    end
    scramble!
  end

  def scramble!
    cards.shuffle!
  end

  def deal_one
    cards.pop
  end

  def size
    cards.size
  end

end

class Card
  attr_accessor :suit, :value

  def initialize(s,v)
    @suit = s
    @value = v
  end

  def to_s
    "the #{value} of #{suit}"
  end

end

module Hand
  def show_hand
    puts "#{name}'s hand "
    cards.each do |card|
      puts "=> #{card}"
    end
    puts "=> Total: #{total}"
  end

  def total
    sum = 0
    numbers_array = cards.map { |card| card.value}

    numbers_array.each do |v|
      if v == "A"
        sum += 11
      elsif v == "J" || v == "Q" || v == "K"
        sum += 10
      else
        sum += v.to_i
      end
    end

    numbers_array.select { |v| v == "A"}.count.times do
      if sum > 21
        sum -=10
      end    
    end

    sum
  end

  def add_card(new_card)
    cards << new_card
  end

  def is_busted?
    total > Game::BLACKJACK_AMOUNT
  end

end

class Dealer
  include Hand

  attr_accessor :name, :cards

  def initialize
    @name = "Dealer"
    @cards = []
  end

  def show_flop
    puts "#{name}'s hand "
    puts "=>First card is hidden"
    puts "=>Second card is #{cards[1]}"
  end

end

class Player
  include Hand 

  attr_accessor :name, :cards

  def initialize(n)
    @name = n
    @cards = []
  end

end

class Game
  attr_accessor :dealer, :player, :deck

  BLACKJACK_AMOUNT = 21
  DEALER_HIT_MIN = 17

  def initialize
    @dealer = Dealer.new
    @player = Player.new("Jeff")
    @deck = Deck.new
  end

  def set_player_name
    puts "What is your name?"
    player.name = gets.chomp
    puts ""
    puts "Welcome, #{player.name}"
    puts ""
  end

  def deal_cards
    dealer.add_card(deck.deal_one)
    player.add_card(deck.deal_one)
    dealer.add_card(deck.deal_one)
    player.add_card(deck.deal_one)
  end

  def show_flop
    player.show_hand
    puts ""
    dealer.show_flop
    puts ""
  end

  def blackjack_or_bust?(player_or_dealer)
    if player_or_dealer.total == BLACKJACK_AMOUNT
      if player_or_dealer.is_a?(Dealer)
        puts "Sorry, dealer hit blackjack. You lose."
      else
        puts "You win Blackjack!"
      end
      play_again?
    elsif player_or_dealer.is_busted?
      if player_or_dealer.is_a?(Dealer)
        puts "Congratulations, dealer busted. You win"
      else
        puts "Sorry, you busted. You lose"
      end
      play_again?
    end
  end

  def player_turn
    puts "#{player.name}'s turn."

    blackjack_or_bust?(player)
    while !player.is_busted?
      puts "What would you like to do? 1) hit 2) stay"
      response = gets.chomp
      puts ""

      if !['1', '2'].include?(response)
        puts "Error: you must enter 1 or 2"
        next
      end

      if response == '2'
        puts "#{player.name} chose to stay."
        break
      end

      new_card = deck.deal_one
      puts "Dealing card to #{player.name}: #{new_card}"
      player.add_card(new_card)
      puts "#{player.name}'s total is now: #{player.total}"
      puts ""

      blackjack_or_bust?(player)
    end
    puts "#{player.name} stays at #{player.total}"
    puts ""
  end

  def dealer_turn
    puts "#{dealer.name}'s turn."
    puts "Dealer's second card is #{dealer.cards[0]} with a total of #{dealer.total}"

    blackjack_or_bust?(dealer)
    while dealer.total < DEALER_HIT_MIN
      new_card = deck.deal_one
      puts "Dealing card to dealer: #{new_card}"
      dealer.add_card(new_card)
      puts "Dealer's total is now: #{dealer.total}"

      blackjack_or_bust?(dealer)
    end
    puts "Dealer stays at #{dealer.total}"

  end

  def compare_total
    if player.total > dealer.total
      puts "Congratulations, #{player.name} wins!"
    elsif player.total < dealer.total
      puts "Sorry, #{player.name} loses"
    else
      puts "It's a tie!"
    end
    play_again?
  end

  def play_again?
    puts ""
    puts "Wanna play again? 1) yes 2) no"
    if gets.chomp == '1'
      puts "--------------------"
      puts "Starting new game..."
      puts "--------------------"
      deck = Deck.new
      player.cards = []
      dealer.cards = []
      play
    else
      puts "Bai"
      exit
    end
  end


  def play
    set_player_name
    deal_cards
    show_flop
    player_turn
    dealer_turn
    compare_total
    play_again?
  end

end

game = Game.new.play

