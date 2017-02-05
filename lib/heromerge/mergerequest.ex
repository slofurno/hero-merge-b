defmodule Heromerge.MergeRequest do
  alias Heromerge.Hero
  alias Heromerge.Heroes
  alias Heromerge.Hero.Attributes
  defstruct [:from, :hero]

  def check_hero(%__MODULE__{from: from, hero: hero} = r) do
    case Enum.count(from) do
      2 ->
        [from1, from2] = Enum.map(from, &Heroes.get/1)
        check_hero(hero, from1, from2)
      _ ->
        {:error, "invalid number of sources"}
    end
  end

  def check_hero(hero, from1, from2) do
    combined_powers = from1.powers ++ from2.powers
    combined_weakness = from1.weaknesses ++ from2.weaknesses

    valid_powers = combined_powers |> contains_all?(hero.powers)
    valid_weakness = hero.weaknesses |> contains_all?(combined_weakness)

    source_attributes = [from1.attributes, from2.attributes]
    valid_attributes = Attributes.from_sources?(hero.attributes, source_attributes)

    if valid_powers and valid_weakness and valid_attributes do
      {:ok, hero}
    else
      {:error, "invalid merge"}
    end
  end

  defp contains_all?(src, subset) do
    Enum.reduce(subset, true, fn(c,a) ->
      a and Enum.member?(src, c)
    end)
  end
end
