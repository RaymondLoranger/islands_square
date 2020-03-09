# ┌────────────────────────────────────────────────────────────────────┐
# │ Based on the book "Functional Web Development" by Lance Halvorsen. │
# └────────────────────────────────────────────────────────────────────┘
defmodule Islands.Square do
  use PersistConfig

  @book_ref Application.get_env(@app, :book_ref)

  @moduledoc """
  Creates a `square` struct for the _Game of Islands_.
  \n##### #{@book_ref}
  """

  alias __MODULE__

  @square_range 1..10

  @derive [Poison.Encoder]
  @derive Jason.Encoder
  @enforce_keys [:row, :col]
  defstruct [:row, :col]

  @type col :: 1..10
  @type row :: 1..10
  @type t :: %Square{row: row, col: col}

  @spec new(row, col) :: {:ok, t} | {:error, atom}
  def new(row, col) when row in @square_range and col in @square_range do
    {:ok, %Square{row: row, col: col}}
  end

  def new(_row, _col), do: {:error, :invalid_square_args}
end
