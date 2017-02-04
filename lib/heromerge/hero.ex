defmodule Heromerge.Hero do
  alias Heromerge.Hero.Attributes
  @genders ["Male", "Female"]

  defstruct [
    :id,
    :real_name,
    :hero_name,
    :gender,
    attributes: %Attributes{},
    powers: [],
    weaknesses: []
  ]

  def check_hero(hero) do
    if valid?(hero) do
      {:ok, hero}
    else
      {:error, "invalid hero"}
    end
  end

  def valid?(%__MODULE__{} = hero) do
    Enum.count(hero.powers) <= 5 and
    Attributes.valid?(hero.attributes) and
    check_names(hero) and
    check_gender(hero) and
    has_power_and_weaknesses(hero)
  end

  defp check_gender(%__MODULE__{gender: gender}) when gender in @genders, do: true
  defp check_gender(_gender), do: false

  defp has_power_and_weaknesses(hero) do
    Enum.count(hero.powers) >= 1# and Enum.count(hero.weaknesses) >= 1
  end

  defp check_names(%__MODULE__{real_name: real_name, hero_name: hero_name}) do
    check_string(real_name) and check_string(hero_name)
  end

  defp check_string(s) when is_binary(s) do
    String.length(String.trim(s)) > 2
  end
  defp check_string(_s), do: false
end

