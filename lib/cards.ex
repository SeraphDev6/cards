defmodule Cards do
  @moduledoc """
    Provides methods for creating and handling a deck of cards.
  """

  @doc """
    Return a list of strings representing a deck of cards
  """
  def create_deck do
    values = ["A","2","3","4","5","6","7","8","9","10","J","Q","K"]
    suits = ["S", "C", "H", "D"]
    for suit <- suits, value <- values  do
        value <> suit
    end
  end

  @doc """
  Return a shuffled list of strings based on the `deck` argument.
  """
  def shuffle(deck) do
    Enum.shuffle(deck)
  end

  @doc """
    Returns whether a `deck` contains a given `card`

    ## Examples

      iex> deck = Cards.create_deck
      iex> Cards.contains?(deck, "AS")
      true

  """
  def contains?(deck, card) do
    Enum.member?(deck, card)
  end

  @doc """
    Divides a deck into a hand and the remainder of the deck.
    The `hand_size` argument indicates how many cards should be dealt.

    ## Examples

      iex> deck = Cards.create_deck
      iex> {hand, deck} = Cards.deal(deck, 2)
      iex> hand
      ["AS","2S"]
      iex> deck
      ["3S", "4S", "5S", "6S", "7S", "8S", "9S", "10S", "JS", "QS", "KS", "AC", "2C",
      "3C", "4C", "5C", "6C", "7C", "8C", "9C", "10C", "JC", "QC", "KC", "AH", "2H",
      "3H", "4H", "5H", "6H", "7H", "8H", "9H", "10H", "JH", "QH", "KH", "AD", "2D",
      "3D", "4D", "5D", "6D", "7D", "8D", "9D", "10D", "JD", "QD", "KD"]

  """
  def deal(deck, hand_size) do
    Enum.split(deck,hand_size)
  end

  def save(deck,file_name) do
    binary = :erlang.term_to_binary(deck)
    File.write(file_name,binary)
  end

  def load(file_name) do
    case File.read(file_name) do
      {:ok, binary} -> :erlang.binary_to_term(binary)
      {:error, _reason} -> "That File does not exists"
    end
  end

  @doc """
    A utility method which calls `create_deck`, `shuffle`, and `deal` with the `hand_size` argument.
  """
  def create_hand(hand_size) do
    Cards.create_deck
    |> Cards.shuffle
    |> Cards.deal(hand_size)
  end
end
