defmodule Heromerge.Hero do
  alias Heromerge.Hero.Attributes

  defstruct [
    :id,
    :real_name,
    :hero_name,
    :gender,
    attributes: %Attributes{},
    powers: [],
    weaknesses: []
  ]

  def valid?(hero) do
    Enum.count(hero.powers) <= 5 and
    Attributes.valid?(hero.attributes)
  end
end

