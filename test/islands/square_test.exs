defmodule Islands.SquareTest do
  use ExUnit.Case, async: true

  alias Islands.Square

  doctest Square

  setup_all do
    {:ok, square} = Square.new(1, 10)
    poison = ~s<{\"row\":1,\"col\":10}>
    jason = ~s<{\"col\":10,\"row\":1}>
    decoded = %{"col" => 10, "row" => 1}

    {:ok,
     json: %{poison: poison, jason: jason, decoded: decoded}, square: square}
  end

  describe "A square struct" do
    test "can be encoded by Poison", %{square: square, json: json} do
      assert Poison.encode!(square) == json.poison
      assert Poison.decode!(json.poison) == json.decoded
    end

    test "can be encoded by Jason", %{square: square, json: json} do
      assert Jason.encode!(square) == json.jason
      assert Jason.decode!(json.jason) == json.decoded
    end
  end

  describe "Square.new/2" do
    test "returns {:ok, ...} given valid args" do
      assert Square.new(1, 10) == {:ok, %Square{row: 1, col: 10}}
    end

    test "returns {:error, ...} given invalid args" do
      assert Square.new(0, 10) == {:error, :invalid_square_args}
      assert Square.new(-1, 2) == {:error, :invalid_square_args}
      assert Square.new("1", "2") == {:error, :invalid_square_args}
    end
  end
end
