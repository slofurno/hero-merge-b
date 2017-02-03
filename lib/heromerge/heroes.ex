defmodule Heromerge.Heroes do
  alias Heromerge.Hero
  alias Heromerge.Hero.Attributes

  @base_url "https://hero-merge.herokuapp.com/"
  @as_hero %Hero{attributes: %Attributes{}}
  @headers [{"Content-Type", "application/json"}]

  def get do
    token = Application.get_env(:heromerge, :api_key)
    %HTTPoison.Response{body: body} = HTTPoison.get! "#{@base_url}#{token}/heroes"
    Poison.decode!(body, as: [@as_hero])
  end

  def get(id) do
    token = Application.get_env(:heromerge, :api_key)
    %HTTPoison.Response{body: body} = HTTPoison.get! "#{@base_url}#{token}/heroes/#{id}"
    Poison.decode!(body, as: @as_hero)
  end

  def create(hero) do
    token = Application.get_env(:heromerge, :api_key)
    body = Poison.encode!(hero |> Map.delete(:id))
    {:ok, %HTTPoison.Response{body: body, status_code: 201}} =
      HTTPoison.post("#{@base_url}#{token}/heroes", body, @headers)
    Poison.decode!(body, as: @as_hero)
  end
end
