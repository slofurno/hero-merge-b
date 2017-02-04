defmodule Heromerge.HeroRouter do
  use Plug.Router
  alias Heromerge.MergeRequest
  alias Heromerge.Hero
  alias Heromerge.Hero.Attributes
  alias Heromerge.Heroes

  @as_hero %Hero{attributes: %Attributes{}}

  plug :match
  plug :dispatch

  get "/" do
    heroes = Poison.encode!(Heroes.get)

    conn
    |> put_resp_content_type("application/json; charset=utf-8")
    |> send_resp(200, heroes)
  end

  post "/" do
    {:ok, body, conn} = read_body(conn)
    hero = Poison.decode!(body, as: @as_hero)
  end

  post "/merge" do
    {:ok, body, conn} = read_body(conn)
    hero = Poison.decode!(body, as: %MergeRequest{hero: @as_hero})
  end

end

