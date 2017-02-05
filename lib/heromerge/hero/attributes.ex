defmodule Heromerge.Hero.Attributes do
  defstruct [:intelligence, :strength, :speed, :durability, :power, :combat]
  @required [:intelligence, :strength, :speed, :durability, :power, :combat]

  def valid?(attributes) do
    Enum.map(@required, &Map.get(attributes, &1))
    |> Enum.reduce(true, fn(attribute, a) ->
      a and valid_attribute?(attribute)
    end)
  end

  def from_sources?(attributes, sources) do
    Enum.reduce(@required, true, fn(attribute, matched) ->
      matched and from_source?(attributes, sources, attribute)
    end)
  end

  #nil values will pass this but fail the valid check
  defp from_source?(attributes, sources, attribute) do
    value = Map.get(attributes, attribute)
    Enum.reduce(sources, false, fn(source, matched) ->
      matched or Map.get(source, attribute) == value
    end)
  end

  defp valid_attribute?(a) when is_number(a) do
    a <= 100 and a >= 0
  end
  defp valid_attribute?(_a), do: false
end
