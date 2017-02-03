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

defmodule Heromerge.Hero.Attributes do
  defstruct [:intelligence, :strength, :speed, :durability, :power, :combat]
  @required [:intelligence, :strength, :speed, :durability, :power, :combat]

  def valid?(attributes) do
    Enum.map(@required, &Map.get(attributes, &1))
    |> Enum.reduce(true, fn(attribute, a) ->
      a and valid_attribute?(attribute)
    end)
  end

  defp valid_attribute?(a) when is_number(a) do
    a <= 100 and a >= 0
  end
  defp valid_attribute?(_a), do: false
end

defmodule Heromerge.Hero do
  alias Heromerge.Hero.Attributes

  defstruct [
    :id,
    :real_name,
    :hero_name,
    attributes: %Attributes{},
    powers: [],
    weaknesses: []
  ]

  def valid?(hero) do
    Enum.count(hero.powers) <= 5 and
    Attributes.valid?(hero.attributes)
  end
end
