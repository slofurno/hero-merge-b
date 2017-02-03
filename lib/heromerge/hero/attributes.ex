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
