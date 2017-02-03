defmodule Heromerge.MergeRequest do
  alias Heromerge.Hero
  defstruct [:from, :hero]

  def valid?(hero, from1, from2) do
    combined_powers = from1.powers ++ from2.powers
    combined_weakness = from1.weaknesses ++ from2.weaknesses

    valid_powers = combined_powers |> contains_all?(hero.powers)
    valid_weakness = hero.weaknesses |> contains_all?(combined_weakness)

    valid_powers and valid_weakness
  end

  defp contains_all?(src, subset) do
    Enum.reduce(subset, true, fn(c,a) ->
      a and Enum.member?(src, c)
    end)
  end
end
